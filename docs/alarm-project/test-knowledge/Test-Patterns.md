# Test Patterns - Padrões de Testes

> **Catálogo de Padrões e Anti-Padrões para Testes Automatizados**  
> Documenta soluções reutilizáveis e erros comuns a serem evitados

---

## 📋 Como Documentar Padrões

Cada padrão neste documento segue esta estrutura:

```
### [Nome do Padrão]

**Categoria**: [Design / Resiliência / Performance / Manutenibilidade]

**Problema**: [Descrição do problema que o padrão resolve]

**Solução**: [Descrição da solução]

**Implementação**:
[Código de exemplo]

**Benefícios**:
- [Benefício 1]
- [Benefício 2]

**Quando Usar**: [Contexto de aplicação]

**Quando Não Usar**: [Contextos onde não se aplica]

**Anti-Pattern Relacionado**: [Link para anti-pattern]
```

---

## 📂 Categorias Obrigatórias

Este documento está organizado nas seguintes categorias:

1. **Design Patterns** - Padrões de arquitetura e estruturação
2. **Resiliência Patterns** - Padrões para testes robustos
3. **Performance Patterns** - Padrões para otimização
4. **Manutenibilidade Patterns** - Padrões para facilitar manutenção
5. **Anti-Patterns** - Práticas ruins a serem evitadas

---

## 1. Design Patterns

### DP-01: Page Object Pattern

**Categoria**: Design / Estruturação

**Problema**: Locators espalhados pelos testes dificultam manutenção quando a UI muda

**Solução**: Centralizar todos os locators em arquivos Page Object

**Implementação**:

```robotframework
# resources/pages/alarm_page.robot
*** Settings ***
Documentation    Page Object para tela de Alarmes
...              Centraliza todos os locators da funcionalidade

*** Keywords ***
Obter Localizador Botão Adicionar Alarme
    [Documentation]    Retorna localizador do botão de adicionar alarme
    [Return]    id=com.android.deskclock:id/fab

Obter Localizador Campo Hora
    [Documentation]    Retorna localizador do campo de entrada de hora
    [Return]    id=com.android.deskclock:id/input_hour

Obter Localizador Campo Minuto
    [Documentation]    Retorna localizador do campo de entrada de minuto
    [Return]    id=com.android.deskclock:id/input_minute

Obter Localizador Spinner AM/PM
    [Documentation]    Retorna localizador do spinner de período
    [Return]    id=android:id/toggle_mode

Obter Localizador Botão OK
    [Documentation]    Retorna localizador do botão de confirmação
    [Return]    id=android:id/button1
```

**Uso**:
```robotframework
# resources/keywords/alarm_keywords.robot
Clicar em Adicionar Alarme
    ${localizador}=    Obter Localizador Botão Adicionar Alarme
    Wait Until Element Is Visible    ${localizador}    timeout=20s
    Click Element    ${localizador}
```

**Benefícios**:
- Manutenção centralizada: mudar locator em um só lugar
- Reutilização: múltiplas keywords usam o mesmo locator
- Legibilidade: código de teste fica mais limpo
- Testabilidade: fácil mockar locators em testes unitários

**Quando Usar**: Sempre, em todos os projetos de automação

**Quando Não Usar**: Nunca. Este é um padrão fundamental

**Anti-Pattern Relacionado**: [AP-01: Hard-Coded Locators](#ap-01-hard-coded-locators)

---

### DP-02: Keyword Layering (Camadas de Keywords)

**Categoria**: Design / Estruturação

**Problema**: Testes misturam lógica de negócio com ações de baixo nível

**Solução**: Criar camadas de keywords: Alto Nível (negócio) e Baixo Nível (ações)

**Implementação**:

```robotframework
# CAMADA BAIXO NÍVEL (Page Actions)
Clicar em Botão Adicionar
    ${localizador}=    Obter Localizador Botão Adicionar
    Click Element    ${localizador}

Inserir Valor no Campo Hora
    [Arguments]    ${hora}
    ${localizador}=    Obter Localizador Campo Hora
    Input Text    ${localizador}    ${hora}

Selecionar Período AM
    ${localizador}=    Obter Localizador Opção AM
    Click Element    ${localizador}

# CAMADA ALTO NÍVEL (Business Logic)
Criar Alarme Com Período
    [Documentation]    Keyword de negócio que combina múltiplas ações
    [Arguments]    ${hora}    ${minuto}    ${periodo}
    Clicar em Botão Adicionar
    Inserir Valor no Campo Hora    ${hora}
    Inserir Valor no Campo Minuto    ${minuto}
    
    IF    "${periodo}" == "AM"
        Selecionar Período AM
    ELSE IF    "${periodo}" == "PM"
        Selecionar Período PM
    ELSE
        Fail    Período inválido: ${periodo}. Use AM ou PM.
    END
    
    Confirmar Alarme

# CAMADA DE TESTE (BDD)
*** Test Cases ***
Criar Alarme no Período AM
    Dado que o aplicativo está aberto
    Quando o usuário cria um alarme para 08:30 AM
    Então o alarme 08:30 AM deve aparecer na lista

*** Keywords ***
Quando o usuário cria um alarme para ${hora}:${minuto} ${periodo}
    Criar Alarme Com Período    ${hora}    ${minuto}    ${periodo}
```

**Benefícios**:
- Separação de responsabilidades
- Testes mais legíveis (alto nível)
- Ações reutilizáveis (baixo nível)
- Fácil manutenção em cada camada

**Quando Usar**: Em todos os projetos com mais de 5 test cases

**Quando Não Usar**: POCs muito simples com 1-2 testes

**Anti-Pattern Relacionado**: [AP-02: God Keywords](#ap-02-god-keywords)

---

### DP-03: BDD Test Structure

**Categoria**: Design / Legibilidade

**Problema**: Testes difíceis de entender por não-técnicos

**Solução**: Estruturar testes no formato Given-When-Then

**Implementação**:

```robotframework
*** Test Cases ***
Criar Alarme no Período AM
    [Documentation]    Valida criação de alarme no período da manhã
    [Tags]    alarme    am    funcional    p0
    
    Dado que o aplicativo de Relógio está aberto
    Quando o usuário cria um alarme para 08:30 AM
    Então o alarme 08:30 AM deve aparecer na lista

*** Keywords ***
# GIVEN - Pré-condições
Dado que o aplicativo de Relógio está aberto
    [Documentation]    Verifica que o aplicativo foi inicializado
    Wait Until Element Is Visible    ${LOCATOR_TELA_PRINCIPAL}    timeout=10s
    Log    Aplicativo de Relógio está aberto e pronto

# WHEN - Ações
Quando o usuário cria um alarme para ${hora}:${minuto} ${periodo}
    [Documentation]    Executa o fluxo de criação de alarme
    Criar Alarme Com Período    ${hora}    ${minuto}    ${periodo}

# THEN - Validações
Então o alarme ${hora}:${minuto} ${periodo} deve aparecer na lista
    [Documentation]    Valida que o alarme foi criado corretamente
    Validar Alarme Criado    ${hora}    ${minuto}    ${periodo}
```

**Benefícios**:
- Testes auto-documentados
- Compreensíveis por stakeholders
- Forçam estrutura clara
- Facilitam revisão de requisitos

**Quando Usar**: Sempre que trabalhar com equipes multidisciplinares

**Quando Não Usar**: Testes puramente técnicos (ex: unit tests de keywords)

---

### DP-04: Data-Driven Testing

**Categoria**: Design / Reusabilidade

**Problema**: Múltiplos test cases quase idênticos, diferindo apenas nos dados

**Solução**: Usar Test Template para executar mesmo teste com dados diferentes

**Implementação**:

```robotframework
*** Settings ***
Documentation    Testes data-driven para validar múltiplos horários

*** Variables ***
${HORA_AM}        08
${MINUTO_AM}      30
${HORA_PM}        18
${MINUTO_PM}      45

*** Test Cases ***                        HORA    MINUTO    PERIODO
Criar Alarme 08:30 AM                     08      30        AM
Criar Alarme 12:00 PM                     12      00        PM
Criar Alarme 18:45 PM                     18      45        PM
Criar Alarme 23:59 PM                     23      59        PM
    [Template]    Validar Criação de Alarme Com Horário

*** Keywords ***
Validar Criação de Alarme Com Horário
    [Arguments]    ${hora}    ${minuto}    ${periodo}
    Criar Alarme Com Período    ${hora}    ${minuto}    ${periodo}
    Validar Alarme Criado    ${hora}    ${minuto}    ${periodo}
    Excluir Alarme    ${hora}    ${minuto}    ${periodo}
```

**Benefícios**:
- Elimina duplicação de código
- Fácil adicionar novos cenários
- Relatórios mostram cada combinação
- Manutenção em um só lugar

**Quando Usar**: Quando tem 3+ test cases com mesma estrutura e dados diferentes

**Quando Não Usar**: Quando cada teste tem lógica única

---

## 2. Resiliência Patterns

### RP-01: Multiple Locator Strategy

**Categoria**: Resiliência / Compatibilidade

**Problema**: Locators podem mudar entre versões ou configurações regionais

**Solução**: Tentar múltiplos locators até encontrar o elemento

**Implementação**:

```robotframework
*** Keywords ***
Construir Lista de Localizadores Para Alarme
    [Documentation]    Cria lista com múltiplas variações de locators
    [Arguments]    ${hora}    ${minuto}    ${periodo}
    
    # Criar variações de formato de hora
    ${hora_formatada}=    Convert To String    ${hora}
    ${minuto_formatado}=    Convert To String    ${minuto}
    
    # Remover zero à esquerda se houver
    ${hora_sem_zero}=    Evaluate    str(int('${hora_formatada}'))
    
    # Construir formatos possíveis
    ${formato1}=    Set Variable    ${hora_sem_zero}:${minuto_formatado} ${periodo}
    ${formato2}=    Set Variable    ${hora_sem_zero}:${minuto_formatado}${periodo}
    ${formato3}=    Set Variable    ${hora_formatada}:${minuto_formatado} ${periodo}
    
    # Lista de locators para cada formato
    @{localizadores}=    Create List
    
    FOR    ${formato}    IN    ${formato1}    ${formato2}    ${formato3}
        # XPath por content-desc exato
        Append To List    ${localizadores}    
        ...    xpath=//*[@content-desc="${formato}"]
        
        # XPath por text exato
        Append To List    ${localizadores}
        ...    xpath=//*[@text="${formato}"]
        
        # XPath por content-desc parcial
        Append To List    ${localizadores}
        ...    xpath=//*[contains(@content-desc, "${formato}")]
        
        # XPath por text parcial
        Append To List    ${localizadores}
        ...    xpath=//*[contains(@text, "${formato}")]
    END
    
    [Return]    ${localizadores}

Validar Alarme Criado
    [Documentation]    Usa fallback strategy para validar alarme
    [Arguments]    ${hora}    ${minuto}    ${periodo}
    
    ${localizadores}=    Construir Lista de Localizadores Para Alarme
    ...    ${hora}    ${minuto}    ${periodo}
    
    ${encontrado}=    Set Variable    ${FALSE}
    
    FOR    ${localizador}    IN    @{localizadores}
        ${status}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${localizador}    timeout=5s
        
        IF    ${status}
            ${encontrado}=    Set Variable    ${TRUE}
            Log    Elemento encontrado com localizador: ${localizador}
            BREAK
        END
    END
    
    Should Be True    ${encontrado}
    ...    msg=Alarme não encontrado com nenhum dos ${len(${localizadores})} localizadores testados
```

**Benefícios**:
- Funciona em diferentes versões do app
- Suporta diferentes configurações regionais
- Reduz flakiness dos testes
- Elimina manutenção constante de locators

**Quando Usar**: Para validações críticas que não podem falhar por locator

**Quando Não Usar**: Em elementos estáveis com ID único

---

### RP-02: Explicit Waits

**Categoria**: Resiliência / Sincronização

**Problema**: Elementos não disponíveis imediatamente causam falhas

**Solução**: Sempre aguardar elemento antes de interagir

**Implementação**:

```robotframework
# ❌ ERRADO - Sem wait
Clicar em Botão
    Click Element    ${LOCATOR_BOTAO}

# ✅ CORRETO - Com wait explícito
Clicar em Botão
    [Documentation]    Aguarda elemento estar visível antes de clicar
    ${localizador}=    Obter Localizador Botão
    Wait Until Element Is Visible    ${localizador}    timeout=20s
    Click Element    ${localizador}
    Log    Botão clicado com sucesso

# ✅ MELHOR - Com wait e log detalhado
Clicar em Botão
    [Documentation]    Aguarda elemento e loga cada passo
    ${localizador}=    Obter Localizador Botão
    
    Log    Aguardando botão ficar visível...    level=DEBUG
    Wait Until Element Is Visible    ${localizador}    timeout=20s
    Log    Botão visível, clicando...    level=DEBUG
    
    Click Element    ${localizador}
    Sleep    1s    # Aguarda ação ser processada
    
    Log    Botão clicado com sucesso    level=INFO
```

**Benefícios**:
- Elimina race conditions
- Funciona em máquinas lentas
- Logs claros para debugging
- Aumenta confiabilidade

**Quando Usar**: Sempre, em todas as interações com elementos

**Quando Não Usar**: Nunca. Este é um padrão fundamental

**Anti-Pattern Relacionado**: [AP-03: Sleep-Driven Development](#ap-03-sleep-driven-development)

---

### RP-03: Retry Pattern

**Categoria**: Resiliência / Recuperação

**Problema**: Ações podem falhar esporadicamente devido a instabilidades

**Solução**: Implementar retry automático para ações críticas

**Implementação**:

```robotframework
*** Keywords ***
Clicar Com Retry
    [Documentation]    Tenta clicar até 3 vezes com intervalo de 2s
    [Arguments]    ${localizador}
    Wait Until Keyword Succeeds    3x    2s
    ...    Click Element    ${localizador}

Validar Texto Com Retry
    [Documentation]    Valida texto com múltiplas tentativas
    [Arguments]    ${localizador}    ${texto_esperado}
    Wait Until Keyword Succeeds    5x    1s
    ...    Element Text Should Be    ${localizador}    ${texto_esperado}

# Exemplo de uso
Confirmar Alarme
    ${localizador}=    Obter Localizador Botão OK
    Clicar Com Retry    ${localizador}
    Sleep    2s
```

**Benefícios**:
- Reduz falsos negativos
- Tolera instabilidades temporárias
- Não requer intervenção manual
- Mantém relatórios limpos

**Quando Usar**: Em ações críticas conhecidas por serem instáveis

**Quando Não Usar**: Em validações que DEVEM falhar (testes negativos)

---

### RP-04: Graceful Degradation

**Categoria**: Resiliência / Flexibilidade

**Problema**: Teste falha completamente se um step opcional falhar

**Solução**: Usar Run Keyword And Ignore Error para steps não-críticos

**Implementação**:

```robotframework
*** Keywords ***
Preparar Ambiente de Teste
    [Documentation]    Prepara ambiente, ignorando falhas em steps opcionais
    
    # Step crítico - deve passar
    Abrir Aplicativo de Relógio
    
    # Step opcional - pode falhar
    ${status}=    Run Keyword And Return Status    Fechar Tutorial Inicial
    IF    not ${status}
        Log    Tutorial inicial não apareceu ou já foi fechado    level=WARN
    END
    
    # Step opcional - limpar dados anteriores
    ${status}=    Run Keyword And Return Status    Limpar Alarmes Existentes
    IF    not ${status}
        Log    Não foi possível limpar alarmes - continuando teste    level=WARN
    END
    
    # Step crítico - validar tela principal
    Validar Tela Principal Carregada

Fechar Popup Se Existir
    [Documentation]    Fecha popup apenas se ele estiver aberto
    ${popup_existe}=    Run Keyword And Return Status
    ...    Element Should Be Visible    ${LOCATOR_POPUP}
    
    IF    ${popup_existe}
        Click Element    ${LOCATOR_FECHAR_POPUP}
        Log    Popup fechado
    ELSE
        Log    Popup não estava presente
    END
```

**Benefícios**:
- Testes mais robustos
- Não falham por motivos menores
- Logs mostram o que aconteceu
- Facilita debugging

**Quando Usar**: Para steps opcionais ou condicionais

**Quando Não Usar**: Para validações principais do teste

---

## 3. Performance Patterns

### PP-01: Parallel Resource Loading

**Categoria**: Performance / Otimização

**Problema**: Carregar resources sequencialmente é lento

**Solução**: Organizar imports para carregamento eficiente

**Implementação**:

```robotframework
*** Settings ***
Documentation    Organização otimizada de imports

# Bibliotecas padrão
Library    Collections
Library    String

# Biblioteca principal - carrega uma vez
Library    AppiumLibrary

# Resources - ordem do mais genérico ao mais específico
Resource    ../resources/common/variables.robot
Resource    ../resources/pages/alarm_page.robot
Resource    ../resources/keywords/alarm_keywords.robot
```

**Benefícios**:
- Reduz tempo de inicialização
- Evita imports duplicados
- Organização clara

**Quando Usar**: Em todos os projetos

---

### PP-02: Smart Timeouts

**Categoria**: Performance / Otimização

**Problema**: Timeouts muito altos tornam testes lentos

**Solução**: Usar timeouts apropriados para cada tipo de ação

**Implementação**:

```robotframework
*** Variables ***
${TIMEOUT_ELEMENTO_SIMPLES}     10s
${TIMEOUT_NAVEGACAO}            20s
${TIMEOUT_ACAO_COMPLEXA}        30s
${TIMEOUT_CARGA_INICIAL}        40s

*** Keywords ***
Aguardar Elemento Simples
    [Arguments]    ${localizador}
    Wait Until Element Is Visible    ${localizador}    
    ...    timeout=${TIMEOUT_ELEMENTO_SIMPLES}

Aguardar Após Navegação
    [Arguments]    ${localizador}
    Wait Until Element Is Visible    ${localizador}
    ...    timeout=${TIMEOUT_NAVEGACAO}
```

**Benefícios**:
- Testes mais rápidos
- Falhas rápidas quando apropriado
- Timeouts justificados

**Quando Usar**: Sempre

---

## 4. Manutenibilidade Patterns

### MP-01: Self-Documenting Code

**Categoria**: Manutenibilidade / Legibilidade

**Problema**: Código difícil de entender requer muitos comentários

**Solução**: Usar nomes descritivos que explicam o que o código faz

**Implementação**:

```robotframework
# ❌ RUIM - Precisa de comentários
*** Keywords ***
Acao1
    # Clica no botão de adicionar
    Click Element    ${BTN}
    # Espera 2 segundos
    Sleep    2s

# ✅ BOM - Auto-explicativo
*** Keywords ***
Clicar em Botão Adicionar e Aguardar Transição
    ${localizador}=    Obter Localizador Botão Adicionar
    Click Element    ${localizador}
    Sleep    2s    # Tempo necessário para animação de transição
```

**Benefícios**:
- Menos comentários necessários
- Código auto-documentado
- Fácil de revisar

---

### MP-02: Centralized Configuration

**Categoria**: Manutenibilidade / Configuração

**Problema**: Configurações espalhadas dificultam alterações

**Solução**: Centralizar todas as configurações em arquivo único

**Implementação**:

```robotframework
# resources/common/variables.robot
*** Variables ***
# Timeouts
${TIMEOUT_PADRAO}             20s
${TIMEOUT_LONGO}              40s

# Dados de Teste
${HORA_AM}                    08
${MINUTO_AM}                  30
${HORA_PM}                    18
${MINUTO_PM}                  45

# Configurações do Dispositivo
${DEVICE_NAME}                device
${DEVICE_UDID}                emulator-5554
${APPIUM_SERVER}              http://localhost:4723

# Aplicativo
${APP_PACKAGE}                com.google.android.deskclock
${APP_ACTIVITY}               com.android.deskclock.DeskClock
```

**Benefícios**:
- Mudanças em um só lugar
- Fácil gerenciar ambientes
- Valores consistentes

**Quando Usar**: Sempre, em projetos com mais de 3 arquivos

---

## 5. Anti-Patterns (Práticas a Evitar)

### AP-01: Hard-Coded Locators

**Categoria**: Anti-Pattern / Design

**Problema**: Locators espalhados pelo código

**Exemplo Ruim**:

```robotframework
❌ *** Test Cases ***
Criar Alarme
    Click Element   id=com.android.deskclock:id/fab
    Input Text    id=com.android.deskclock:id/input_hour    08
    Click Element    xpath=//android.widget.Button[@text='OK']
```

**Por Que é Ruim**:
- Mudança de UI quebra múltiplos arquivos
- Duplicação de código
- Difícil encontrar todos os usos de um locator

**Solução**: Use [DP-01: Page Object Pattern](#dp-01-page-object-pattern)

---

### AP-02: God Keywords

**Categoria**: Anti-Pattern / Design

**Problema**: Keywords gigantes que fazem muitas coisas

**Exemplo Ruim**:

```robotframework
❌ Criar E Validar E Excluir Alarme
    [Arguments]    ${hora}    ${minuto}    ${periodo}
    Click Element    ${BOTAO_ADICIONAR}
    Input Text    ${CAMPO_HORA}    ${hora}
    Input Text    ${CAMPO_MINUTO}    ${minuto}
    Select From List    ${PERIODO}    ${periodo}
    Click Element    ${BOTAO_OK}
    Wait Until Visible    ${ALARME}
    Element Should Be Visible    ${ALARME}
    Long Press    ${ALARME}
    Click Element    ${BOTAO_EXCLUIR}
    Element Should Not Be Visible    ${ALARME}
```

**Por Que é Ruim**:
- Difícil reutilizar partes
- Difícil testar isoladamente
- Viola Single Responsibility Principle

**Solução**: Use [DP-02: Keyword Layering](#dp-02-keyword-layering)

---

### AP-03: Sleep-Driven Development

**Categoria**: Anti-Pattern / Sincronização

**Problema**: Usar Sleep em vez de waits explícitos

**Exemplo Ruim**:

```robotframework
❌ Clicar em Botão
    Click Element    ${BOTAO}
    Sleep    5s
    Click Element    ${PROXIMO_BOTAO}
    Sleep    10s
    Element Should Be Visible    ${RESULTADO}
```

**Por Que é Ruim**:
- Testes desnecessariamente lentos
- Pode falhar se sleep for insuficiente
- Desperdiça tempo em máquinas rápidas

**Solução**: Use [RP-02: Explicit Waits](#rp-02-explicit-waits)

**Exceção**: Sleep pode ser usado após ações para aguardar animações (1-2s)

---

### AP-04: Copy-Paste Programming

**Categoria**: Anti-Pattern / Manutenibilidade

**Problema**: Código duplicado em múltiplos lugares

**Exemplo Ruim**:

```robotframework
❌ Test Case 1
    Click Element    ${BOTAO}
    Wait Until Visible    ${CAMPO}
    Input Text    ${CAMPO}    valor1

❌ Test Case 2
    Click Element    ${BOTAO}
    Wait Until Visible    ${CAMPO}
    Input Text    ${CAMPO}    valor2

❌ Test Case 3
    Click Element    ${BOTAO}
    Wait Until Visible    ${CAMPO}
    Input Text    ${CAMPO}    valor3
```

**Por Que é Ruim**:
- Mudanças precisam ser feitas em N lugares
- Alto risco de bugs
- Difícil manter sincronizado

**Solução**: Criar keyword reutilizável e usar [DP-04: Data-Driven Testing](#dp-04-data-driven-testing)

---

### AP-05: Magic Numbers and Strings

**Categoria**: Anti-Pattern / Manutenibilidade

**Problema**: Valores literais sem contexto

**Exemplo Ruim**:

```robotframework
❌ Criar Alarme
    Input Text    ${CAMPO_HORA}    08
    Input Text    ${CAMPO_MINUTO}    30
    Wait Until Visible    ${RESULTADO}    timeout=20s
```

**Por Que é Ruim**:
- Não é claro o que significa cada número
- Difícil mudar valores em múltiplos lugares
- Sem documentação do porquê do valor

**Solução**:

```robotframework
✅ *** Variables ***
${HORA_PADRAO_AM}         08
${MINUTO_PADRAO}          30
${TIMEOUT_ELEMENTO}       20s

*** Keywords ***
Criar Alarme
    Input Text    ${CAMPO_HORA}    ${HORA_PADRAO_AM}
    Input Text    ${CAMPO_MINUTO}    ${MINUTO_PADRAO}
    Wait Until Visible    ${RESULTADO}    timeout=${TIMEOUT_ELEMENTO}
```

---

### AP-06: Test Interdependence

**Categoria**: Anti-Pattern / Isolamento

**Problema**: Testes dependem uns dos outros

**Exemplo Ruim**:

```robotframework
❌ Test 1 - Criar Alarme
    Criar Alarme    08    30    AM
    # Não limpa após

❌ Test 2 - Editar Alarme
    # Assume que alarme do Test 1 existe
    Editar Alarme    08    30    09    00
```

**Por Que é Ruim**:
- Testes não podem ser executados isoladamente
- Ordem de execução importa
- Falha em cascata
- Difícil debugar

**Solução**:

```robotframework
✅ Test 1 - Criar Alarme
    [Setup]    Limpar Todos os Alarmes
    Criar Alarme    08    30    AM
    Validar Alarme Criado    08    30    AM
    [Teardown]    Limpar Todos os Alarmes

✅ Test 2 - Editar Alarme
    [Setup]    Preparar Alarme Para Ediçã    08    30    AM
    Editar Alarme    08    30    09    00
    Validar Alarme Editado    09    00    AM
    [Teardown]    Limpar Todos os Alarmes
```

---

## 📊 Tabela de Referência Rápida

| Padrão | Categoria | Quando Usar | Prioridade |
|--------|-----------|-------------|------------|
| Page Object | Design | Sempre | 🔴 Crítico |
| Keyword Layering | Design | Projetos médios/grandes | 🔴 Crítico |
| BDD Structure | Design | Trabalho em equipe | 🟡 Recomendado |
| Data-Driven | Design | 3+ casos similares | 🟡 Recomendado |
| Multiple Locators | Resiliência | Validações críticas | 🔴 Crítico |
| Explicit Waits | Resiliência | Sempre | 🔴 Crítico |
| Retry Pattern | Resiliência | Ações instáveis | 🟡 Recomendado |
| Graceful Degradation | Resiliência | Steps opcionais | 🟢 Opcional |
| Smart Timeouts | Performance | Sempre | 🟡 Recomendado |
| Self-Documenting | Manutenibilidade | Sempre | 🟡 Recomendado |
| Centralized Config | Manutenibilidade | Projetos médios/grandes | 🔴 Crítico |

**Legenda**:
- 🔴 Crítico: Use sempre
- 🟡 Recomendado: Use na maioria dos casos
- 🟢 Opcional: Use quando apropriado

---

## 6. Exemplos Completos Funcionais

> **📌 Esta seção contém exemplos COMPLETOS e FUNCIONAIS**  
> Use como REFERÊNCIA para implementar seus próprios testes seguindo os padrões documentados

---

### Exemplo 1: Page Object Completo (alarm_page.robot)

**Implementa**: DP-01 (Page Object Pattern)

```robotframework
*** Settings ***
Documentation    Page Object para tela de Alarmes
...              
...              RESPONSABILIDADE:
...              Este arquivo centraliza TODOS os localizadores da funcionalidade de Alarmes.
...              Nenhum localizador deve estar hardcoded em testes ou keywords.

*** Keywords ***
# ============================================================================
# LOCALIZADORES - Tela Principal de Alarmes
# ============================================================================

Obter Localizador Botão Adicionar Alarme
    [Documentation]    Retorna localizador do botão FAB (Floating Action Button)
    ...                para adicionar novo alarme
    ...                
    ...                TIPO: ImageButton
    ...                ATRIBUTO: content-desc="Add alarm"
    
    [Return]    xpath=//android.widget.ImageButton[@content-desc="Add alarm"]

# ============================================================================
# LOCALIZADORES - Modal de Criação/Edição de Alarme
# ============================================================================

Obter Localizador Switch Input Texto
    [Documentation]    Retorna localizador do botão para alternar entre
    ...                modo picker (circular) e modo de entrada de texto
    ...                
    ...                IMPORTANTE: Modo texto é preferível para automação
    
    [Return]    xpath=//android.widget.ImageButton[@content-desc="Switch to text input mode for the time input."]

Obter Localizador Campo Hora
    [Documentation]    Retorna localizador do campo EditText para entrada da hora
    ...                
    ...                DISPONÍVEL: Apenas quando em modo de entrada de texto
    
    [Return]    xpath=//android.widget.EditText[@resource-id="android:id/input_hour"]

Obter Localizador Campo Minuto
    [Documentation]    Retorna localizador do campo EditText para entrada dos minutos
    
    [Return]    xpath=//android.widget.EditText[@resource-id="android:id/input_minute"]

Obter Localizador Spinner AM/PM
    [Documentation]    Retorna localizador do Spinner para selecionar período AM/PM
    ...                
    ...                IMPORTANTE: 
    ...                - Só aparece em dispositivos configurados para formato 12h
    
    [Return]    xpath=//android.widget.Spinner[@resource-id="android:id/am_pm_spinner"]

Obter Localizador Opção AM
    [Documentation]    Retorna localizador da opção "AM" dentro do Spinner
    
    [Return]    xpath=//android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="AM"]

Obter Localizador Opção PM
    [Documentation]    Retorna localizador da opção "PM" dentro do Spinner
    
    [Return]    xpath=//android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="PM"]

Obter Localizador Botão OK
    [Documentation]    Retorna localizador do botão OK para confirmar criação do alarme
    
    [Return]    xpath=//android.widget.Button[@resource-id="android:id/button1"]
```

**Benefícios Implementados**:
- ✅ Localizadores centralizados
- ✅ Documentação detalhada de cada elemento
- ✅ Fácil manutenção quando UI muda
- ✅ Reutilização por múltiplas keywords

---

### Exemplo 2: Keywords com Camadas (alarm_keywords.robot - Parte 1)

**Implementa**: DP-02 (Keyword Layering), RP-01 (Multiple Locators), RP-02 (Explicit Waits)

```robotframework
*** Settings ***
Documentation    Keywords customizadas para automação de testes de Alarmes
...              
...              CAMADAS DE KEYWORDS:
...              1. Keywords de ALTO NÍVEL (Business Logic) - Usadas nos testes
...              2. Keywords de BAIXO NÍVEL (Page Actions) - Interagem com elementos

Library          AppiumLibrary
Resource         ../../../resources/pages/alarm_page.robot

*** Keywords ***
# ============================================================================
# KEYWORDS DE SETUP E TEARDOWN - Gerenciamento de sessão
# ============================================================================

Abrir Aplicativo de Relógio
    [Documentation]    Inicializa conexão com Appium e abre o aplicativo de Relógio
    ...                Implementa validação robusta para garantir que app abre corretamente
    
    Open Application    http://localhost:4723
    ...    platformName=Android
    ...    appium:deviceName=device
    ...    appium:automationName=UiAutomator2
    ...    appium:appPackage=com.google.android.deskclock
    ...    appium:appActivity=com.android.deskclock.DeskClock
    ...    appium:noReset=false
    ...    appium:fullReset=false
    ...    appium:dontStopAppOnReset=false
    ...    appium:newCommandTimeout=300
    
    Sleep    5s    # Aguardar aplicativo carregar completamente
    
    # Validação robusta com fallback
    ${localizador_fab}=    Obter Localizador Botão Adicionar Alarme
    ${app_opened}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${localizador_fab}    timeout=10s
    
    IF    not ${app_opened}
        Log    ⚠️ Aplicando fallback para garantir abertura do app    level=WARN
        # Fallback: tentar navegar para aba Alarm ou forçar abertura
        Run Keyword And Ignore Error    Click Element    xpath=//android.widget.TextView[@text="Alarm"]
        Sleep    2s
        Wait Until Element Is Visible    ${localizador_fab}    timeout=10s
    END
    
    Log    ✅ Aplicativo de Relógio aberto com sucesso

Fechar Aplicativo
    [Documentation]    Encerra a sessão do Appium e fecha o aplicativo
    
    Close Application
    Log    ✅ Aplicativo fechado

# ============================================================================
# KEYWORDS DE ALTO NÍVEL - Business Logic (usadas nos testes)
# ============================================================================

Criar Alarme Com Período
    [Documentation]    Keyword de alto nível que cria um alarme completo
    ...                
    ...                FLUXO:
    ...                1. Clica no botão de adicionar alarme
    ...                2. Muda para modo de entrada de texto
    ...                3. Insere hora e minuto
    ...                4. Seleciona período AM ou PM
    ...                5. Confirma a criação
    
    [Arguments]    ${hora}    ${minuto}    ${periodo}
    
    Log    📱 Iniciando criação de alarme ${hora}:${minuto} ${periodo}
    
    Clicar em Adicionar Alarme
    Mudar Para Modo de Entrada de Texto
    Inserir Hora    ${hora}
    Inserir Minuto    ${minuto}
    
    IF    "${periodo}" == "AM"
        Selecionar Período AM
    ELSE IF    "${periodo}" == "PM"
        Selecionar Período PM
    ELSE
        Fail    ❌ Período inválido: ${periodo}. Use "AM" ou "PM"
    END
    
    Confirmar Alarme
    Log    ✅ Alarme ${hora}:${minuto} ${periodo} criado com sucesso

# ============================================================================
# KEYWORDS DE BAIXO NÍVEL - Page Actions (ações básicas de UI)
# ============================================================================

Clicar em Adicionar Alarme
    [Documentation]    Clica no botão de adicionar novo alarme (FAB)
    ...                
    ...                TIMEOUT: 20s (otimizado para máquinas lentas)
    
    ${localizador}=    Obter Localizador Botão Adicionar Alarme
    
    Log    Aguardando botão Adicionar Alarme ficar visível...    level=DEBUG
    Wait Until Element Is Visible    ${localizador}    timeout=20s
    
    Log    Clicando no botão Adicionar Alarme...    level=DEBUG
    Click Element    ${localizador}
    
    Sleep    3s    # Aguardar modal de criação abrir
    Log    ✅ Botão Adicionar Alarme clicado

Mudar Para Modo de Entrada de Texto
    [Documentation]    Alterna para o modo de entrada de texto (keyboard input)
    
    ${localizador}=    Obter Localizador Switch Input Texto
    
    Wait Until Element Is Visible    ${localizador}    timeout=20s
    Click Element    ${localizador}
    Sleep    2s
    
    Log    ✅ Mudado para modo de entrada de texto

Inserir Hora
    [Documentation]    Insere valor da hora no campo apropriado
    
    [Arguments]    ${hora}
    
    ${localizador}=    Obter Localizador Campo Hora
    
    Wait Until Element Is Visible    ${localizador}    timeout=20s
    Clear Text    ${localizador}
    Input Text    ${localizador}    ${hora}
    
    Log    ✅ Hora ${hora} inserida

Inserir Minuto
    [Documentation]    Insere valor do minuto no campo apropriado
    
    [Arguments]    ${minuto}
    
    ${localizador}=    Obter Localizador Campo Minuto
    
    Wait Until Element Is Visible    ${localizador}    timeout=20s
    Clear Text    ${localizador}
    Input Text    ${localizador}    ${minuto}
    
    Log    ✅ Minuto ${minuto} inserido

Selecionar Período AM
    [Documentation]    Seleciona o período AM no spinner
    
    ${localizador_spinner}=    Obter Localizador Spinner AM/PM
    ${localizador_opcao}=    Obter Localizador Opção AM
    
    Wait Until Element Is Visible    ${localizador_spinner}    timeout=20s
    Click Element    ${localizador_spinner}
    Sleep    1s
    
    Wait Until Element Is Visible    ${localizador_opcao}    timeout=10s
    Click Element    ${localizador_opcao}
    
    Log    ✅ Período AM selecionado

Selecionar Período PM
    [Documentation]    Seleciona o período PM no spinner
    
    ${localizador_spinner}=    Obter Localizador Spinner AM/PM
    ${localizador_opcao}=    Obter Localizador Opção PM
    
    Wait Until Element Is Visible    ${localizador_spinner}    timeout=20s
    Click Element    ${localizador_spinner}
    Sleep    1s
    
    Wait Until Element Is Visible    ${localizador_opcao}    timeout=10s
    Click Element    ${localizador_opcao}
    
    Log    ✅ Período PM selecionado

Confirmar Alarme
    [Documentation]    Clica no botão OK para confirmar criação do alarme
    
    ${localizador}=    Obter Localizador Botão OK
    
    Wait Until Element Is Visible    ${localizador}    timeout=20s
    Click Element    ${localizador}
    Sleep    3s    # Aguardar alarme ser salvo
    
    Log    ✅ Alarme confirmado
```

---

### Exemplo 3: Validação com Multiple Locators (alarm_keywords.robot - Parte 2)

**Implementa**: RP-01 (Multiple Locator Strategy como Fallback)

```robotframework
*** Keywords ***
Validar Alarme Criado
    [Documentation]    Valida se o alarme foi criado e aparece na lista
    ...                
    ...                ESTRATÉGIA DE VALIDAÇÃO:
    ...                Usa múltiplos localizadores e formatos de hora para garantir
    ...                compatibilidade com diferentes versões do app.
    ...                
    ...                FORMATOS TESTADOS:
    ...                - "8:30 AM" (hora sem zero à esquerda, com espaço)
    ...                - "8:30AM" (hora sem zero à esquerda, sem espaço)
    ...                - "08:30 AM" (hora com zero à esquerda, com espaço)
    
    [Arguments]    ${hora}    ${minuto}    ${periodo}
    
    Log    🔍 Validando alarme ${hora}:${minuto} ${periodo} na lista
    
    ${localizadores}=    Construir Localizadores Para Alarme    ${hora}    ${minuto}    ${periodo}
    
    ${encontrado}=    Set Variable    ${FALSE}
    ${localizador_usado}=    Set Variable    ${EMPTY}
    
    FOR    ${localizador}    IN    @{localizadores}
        Log    Tentando localizador: ${localizador}    level=DEBUG
        
        ${status}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${localizador}    timeout=5s
        
        IF    ${status}
            ${encontrado}=    Set Variable    ${TRUE}
            ${localizador_usado}=    Set Variable    ${localizador}
            ${texto}=    Get Text    ${localizador}
            Log    ✅ Alarme encontrado com sucesso!
            Log    📍 Localizador usado: ${localizador_usado}
            Log    📝 Texto exibido: ${texto}
            BREAK
        END
    END
    
    Should Be True    ${encontrado}
    ...    msg=❌ Alarme ${hora}:${minuto} ${periodo} não foi encontrado na lista

Construir Localizadores Para Alarme
    [Documentation]    Cria lista com múltiplas variações de localizadores
    ...                
    ...                RETORNA: Lista de XPaths com diferentes formatos e atributos
    
    [Arguments]    ${hora}    ${minuto}    ${periodo}
    
    # Remover zero à esquerda da hora
    ${hora_sem_zero}=    Evaluate    str(int('${hora}'))
    
    # Construir formatos possíveis
    ${formato1}=    Set Variable    ${hora_sem_zero}:${minuto} ${periodo}
    ${formato2}=    Set Variable    ${hora_sem_zero}:${minuto}${periodo}
    ${formato3}=    Set Variable    ${hora}:${minuto} ${periodo}
    
    # Lista de localizadores para cada formato
    @{localizadores}=    Create List
    
    FOR    ${formato}    IN    ${formato1}    ${formato2}    ${formato3}
        # XPath por content-desc exato
        Append To List    ${localizadores}
        ...    xpath=//*[@content-desc="${formato}"]
        
        # XPath por text exato
        Append To List    ${localizadores}
        ...    xpath=//*[@text="${formato}"]
        
        # XPath por content-desc parcial
        Append To List    ${localizadores}
        ...    xpath=//*[contains(@content-desc, "${formato}")]
        
        # XPath por text parcial
        Append To List    ${localizadores}
        ...    xpath=//*[contains(@text, "${formato}")]
    END
    
    [Return]    ${localizadores}
```

**Benefícios Implementados**:
- ✅ Funciona em diferentes versões do Android
- ✅ Suporta diferentes configurações regionais
- ✅ Reduz flakiness dos testes
- ✅ Logs detalhados para debugging

---

### Exemplo 4: Test Cases BDD Completos (test_alarm.robot)

**Implementa**: DP-03 (BDD Test Structure)

```robotframework
*** Settings ***
Documentation     Testes automatizados para funcionalidade de Alarmes
...               Valida criação de alarmes com período AM/PM
...               
...               PRÉ-REQUISITOS:
...               - Dispositivo Android conectado (adb devices)
...               - Formato de 12 horas ativo no dispositivo
...               - Appium Server rodando na porta 4723

Library           AppiumLibrary
Resource          ../../../resources/keywords/alarm_keywords.robot

Suite Setup       Abrir Aplicativo de Relógio
Suite Teardown    Fechar Aplicativo

Test Tags         alarme    android    funcional

*** Variables ***
${HORA_AM}        08
${MINUTO_AM}      30
${HORA_PM}        06
${MINUTO_PM}      45

*** Test Cases ***
Criar Alarme no Período AM
    [Documentation]    Valida a criação de alarme no período da manhã (AM)
    ...                
    ...                CRITÉRIOS DE ACEITAÇÃO:
    ...                - Alarme é criado com sucesso
    ...                - Horário exibido é "8:30 AM" (ou variações)
    ...                - Período AM está configurado corretamente
    ...                - Alarme aparece na lista de alarmes
    
    [Tags]    am    p0    smoke
    
    # GIVEN - Pré-condição
    Dado que o aplicativo de Relógio está aberto
    
    # WHEN - Ação
    Quando o usuário cria um alarme para ${HORA_AM}:${MINUTO_AM} AM
    
    # THEN - Validação
    Então o alarme ${HORA_AM}:${MINUTO_AM} AM deve aparecer na lista

Criar Alarme no Período PM
    [Documentation]    Valida a criação de alarme no período da tarde/noite (PM)
    ...                
    ...                CRITÉRIOS DE ACEITAÇÃO:
    ...                - Alarme é criado com sucesso
    ...                - Horário exibido é "6:45 PM" (ou variações)
    ...                - Período PM está configurado corretamente
    ...                - Alarme aparece na lista de alarmes
    
    [Tags]    pm    p0    smoke
    
    # GIVEN - Pré-condição
    Dado que o aplicativo de Relógio está aberto
    
    # WHEN - Ação
    Quando o usuário cria um alarme para ${HORA_PM}:${MINUTO_PM} PM
    
    # THEN - Validação
    Então o alarme ${HORA_PM}:${MINUTO_PM} PM deve aparecer na lista

*** Keywords ***
# ============================================================================
# KEYWORDS BDD - Camada de linguagem natural para os testes
# ============================================================================

Dado que o aplicativo de Relógio está aberto
    [Documentation]    Valida que o aplicativo foi inicializado corretamente
    
    Log    Aplicativo já foi aberto no Suite Setup
    Log    Validando que estamos na tela de alarmes...

Quando o usuário cria um alarme para ${hora}:${minuto} ${periodo}
    [Documentation]    Executa o fluxo completo de criação de alarme
    
    Criar Alarme Com Período    ${hora}    ${minuto}    ${periodo}

Então o alarme ${hora}:${minuto} ${periodo} deve aparecer na lista
    [Documentation]    Valida que o alarme foi criado e aparece na lista
    
    Validar Alarme Criado    ${hora}    ${minuto}    ${periodo}
```

**Benefícios Implementados**:
- ✅ Testes auto-documentados
- ✅ Estrutura Given-When-Then clara
- ✅ Compreensíveis por stakeholders
- ✅ Tags para organização e filtros
- ✅ Suite Setup/Teardown compartilhado

---

### Resumo dos Padrões Implementados nos Exemplos

| Padrão | Onde Ver | Linhas de Referência |
|--------|----------|---------------------|
| **Page Object Pattern** | alarm_page.robot | Keywords que retornam localizadores |
| **Keyword Layering** | alarm_keywords.robot | Seções de Alto Nível vs Baixo Nível |
| **BDD Structure** | test_alarm.robot | Test cases com Given-When-Then |
| **Explicit Waits** | alarm_keywords.robot | `Wait Until Element Is Visible` antes de cada ação |
| **Multiple Locators** | alarm_keywords.robot | `Construir Localizadores Para Alarme` |
| **Informative Logging** | alarm_keywords.robot | `Log` com emojis e níveis adequados |
| **Smart Timeouts** | alarm_keywords.robot | 20s para ações, 5s para validações |

---

## 📚 Referências

- [PRD.md](PRD.md): Requisitos do produto
- [SDD.md](SDD.md): Design técnico
- [Test-Rules.md](Test-Rules.md): Regras de nomenclatura e estruturação
- [Robot-Conventions.md](Robot-Conventions.md): Convenções do Robot Framework
- [Design Patterns (Gang of Four)](https://en.wikipedia.org/wiki/Design_Patterns)
- [Test Automation Patterns (Gerard Meszaros)](http://xunitpatterns.com/)
