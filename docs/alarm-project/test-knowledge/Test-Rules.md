# Test Rules - Regras de Testes

> **Documento de Referência para Regras e Padrões de Testes**  
> Define regras obrigatórias para nomenclatura, estruturação e validação de testes

---

## 📋 Seções Obrigatórias

Este documento está dividido em:

1. **Regras de Nomenclatura** - Como nomear testes, keywords e variáveis
2. **Regras de Estruturação** - Como organizar arquivos e código
3. **Regras de Validação** - Como implementar asserções e verificações
4. **Regras de Documentação** - Como documentar testes e keywords
5. **Regras de Manutenibilidade** - Boas práticas para facilitar manutenção
6. **Regras de Criação de Arquivos** - Restrições sobre arquivos permitidos

---

## ⚠️ REGRA CRÍTICA: Restrição de Criação de Arquivos Markdown

### RN-ARQ-001: Proibição de Criar Arquivos .md Durante Implementação

**Regra**: Ferramentas de IA (Copilot, assistentes, etc) **NÃO devem criar arquivos Markdown (.md)** ao implementar testes a partir da documentação existente.

**Exceção Única**: README.md na raiz do projeto para instruções de execução.

**Arquivos Permitidos**:
- ✅ README.md (apenas na raiz, com instruções de setup e execução)
- ✅ Arquivos .robot (testes, keywords, pages)
- ✅ requirements.txt
- ✅ Scripts de automação (.sh, .bat, .py)
- ✅ Arquivos de configuração (.json, .yaml, .ini)

**Arquivos Proibidos**:
- ❌ CHANGELOG.md
- ❌ SUMMARY.md
- ❌ CHANGES.md
- ❌ ANALYSIS.md
- ❌ IMPLEMENTATION.md
- ❌ Qualquer outro arquivo .md além do README.md

**Justificativa**:
- Documentação completa já existe em docs/
- Evitar duplicação de informação
- Facilitar manutenção (fonte única de verdade)
- README.md é suficiente para instruções de uso

**Violação**: Criar arquivos .md adicionais é considerado violação desta regra e deve ser evitado

---

## 1. Regras de Nomenclatura

### 🔖 Teste Cases

#### RN-NOM-001: Nome de Test Case em Português Descritivo

**Regra**: Test cases devem ter nomes em português, claros e descritivos

**Formato**:
```
[Ação] [Objeto] [Condição/Contexto]
```

**Exemplos Válidos**:
```robotframework
✅ Criar Alarme no Período AM
✅ Validar Exibição de Erro em Campo Vazio
✅ Editar Alarme Existente Com Sucesso
```

**Exemplos Inválidos**:
```robotframework
❌ Test 1
❌ CreateAlarmAM
❌ teste_criar_alarme
❌ T001_Alarme
```

**Justificativa**: Nomes descritivos facilitam compreensão e manutenção

---

#### RN-NOM-002: Keywords em Português com Verbos no Infinitivo

**Regra**: Keywords customizadas devem iniciar com verbo no infinitivo

**Formato**:
```
[Verbo no Infinitivo] [Complemento]
```

**Exemplos Válidos**:
```robotframework
✅ Clicar em Botão Adicionar
✅ Inserir Texto no Campo
✅ Validar Mensagem de Erro
✅ Obter Localizador do Elemento
✅ Verificar Se Elemento Está Visível
```

**Exemplos Inválidos**:
```robotframework
❌ Clicando em Botão
❌ Clique no Botão
❌ click_button
❌ BotaoClicado
```

**Exceções**:
- Keywords de setup/teardown podem não seguir esse padrão
- Exemplo: `Abrir Aplicativo de Relógio` (aceito)

---

#### RN-NOM-003: Variáveis em Maiúsculas com Underscores

**Regra**: Variáveis devem ser nomeadas em MAIÚSCULAS separadas por underscores

**Formato**:
```
${NOME_DESCRITIVO}
```

**Exemplos Válidos**:
```robotframework
✅ ${HORA_AM}
✅ ${MINUTO_PM}
✅ ${TIMEOUT_PADRAO}
✅ ${MENSAGEM_ERRO_ESPERADA}
```

**Exemplos Inválidos**:
```robotframework
❌ ${horaAm}
❌ ${hora-am}
❌ ${Hora_AM}
❌ ${hora}
```

**Exceção**: Variáveis locais em keywords podem usar lowercase
```robotframework
${localizador}=    Obter Localizador
```

---

#### RN-NOM-004: Arquivos em Snake Case

**Regra**: Arquivos .robot devem usar snake_case com prefixo indicando tipo

**Formato**:
```
test_[nome].robot      # Arquivos de teste
[nome]_keywords.robot  # Arquivos de keywords
[nome]_page.robot      # Arquivos de Page Objects
```

**Exemplos Válidos**:
```
✅ test_alarm.robot
✅ alarm_keywords.robot
✅ alarm_page.robot
✅ test_login.robot
```

**Exemplos Inválidos**:
```
❌ TestAlarm.robot
❌ test-alarm.robot
❌ Alarm.robot
❌ alarme.robot
```

---

## 2. Regras de Estruturação

### 🏗️ Organização de Arquivos

#### RN-EST-001: Separação em Três Camadas

**Regra**: Projeto deve ter três camadas distintas

**Estrutura Obrigatória**:
```
/tests          - Test cases (BDD)
/keywords       - Business logic
/pages          - Page Objects (locators)
```

**Validação**:
- ❌ Locators não devem estar em arquivos de teste
- ❌ Lógica de negócio não deve estar em Page Objects
- ✅ Cada camada tem responsabilidade única e clara

---

#### RN-EST-002: Um Arquivo de Teste por Funcionalidade

**Regra**: Cada funcionalidade deve ter seu próprio arquivo de teste

**Exemplo**:
```
test_alarm.robot        # Testes de alarme
test_timer.robot        # Testes de timer
test_stopwatch.robot    # Testes de cronômetro
```

**Proibido**:
```
❌ test_all.robot       # Tudo em um arquivo
❌ test_1.robot         # Nome genérico
```

---

#### RN-EST-003: Estrutura de Settings Consistente

**Regra**: Todo arquivo de teste deve ter Settings na seguinte ordem

**Ordem Obrigatória**:
```robotframework
*** Settings ***
Documentation     [Descrição do arquivo]
Library           [Bibliotecas externas]
Resource          [Recursos personalizados]
Suite Setup       [Setup do suite]
Suite Teardown    [Teardown do suite]
Test Setup        [Setup de cada teste]
Test Teardown     [Teardown de cada teste]
```

**Exemplo**:
```robotframework
*** Settings ***
Documentation     Testes de funcionalidade de Alarmes
Library           AppiumLibrary
Library           Collections
Resource          ../resources/keywords/alarm_keywords.robot
Resource          ../resources/pages/alarm_page.robot
Suite Setup       Abrir Aplicativo de Relógio
Suite Teardown    Fechar Aplicativo
Test Setup        Limpar Alarmes Existentes
Test Teardown     Capturar Screenshot Em Caso De Falha
```

---

#### RN-EST-004: Ordem das Seções no Arquivo

**Regra**: Arquivos .robot devem seguir ordem padrão de seções

**Ordem Obrigatória**:
```robotframework
*** Settings ***
*** Variables ***
*** Test Cases ***
*** Keywords ***
```

**Proibido**:
```
❌ Keywords antes de Test Cases
❌ Variables antes de Settings
❌ Múltiplas seções do mesmo tipo
```

---

### 🧩 Organização de Código

#### RN-EST-005: Test Case com Estrutura BDD

**Regra**: Test cases devem seguir estrutura Given-When-Then

**Estrutura Obrigatória**:
```robotframework
[Nome do Test Case]
    [Documentation]    [Descrição]
    [Tags]    [tags]
    Dado [pré-condição]
    Quando [ação]
    Então [validação]
```

**Exemplo**:
```robotframework
Criar Alarme no Período AM
    [Documentation]    Valida criação de alarme no período da manhã
    [Tags]    alarme    am    p0
    Dado que o aplicativo de Relógio está aberto
    Quando o usuário cria um alarme para 08:30 AM
    Então o alarme 08:30 AM deve aparecer na lista
```

---

#### RN-EST-006: Keywords com Documentation

**Regra**: Toda keyword customizada deve ter [Documentation]

**Formato Obrigatório**:
```robotframework
[Nome da Keyword]
    [Documentation]    [Descrição do que faz]
    ...                [Descrições adicionais]
    [Arguments]    [args se houver]
    [Implementation]
```

**Exemplo**:
```robotframework
Criar Alarme Com Período
    [Documentation]    Cria um alarme completo com hora, minuto e período AM/PM
    ...                Combina todas as ações necessárias em uma única keyword
    [Arguments]    ${hora}    ${minuto}    ${periodo}
    Clicar em Adicionar Alarme
    Inserir Hora    ${hora}
    Inserir Minuto    ${minuto}
    
    IF    "${periodo}" == "AM"
        Selecionar Período AM
    ELSE IF    "${periodo}" == "PM"
        Selecionar Período PM
    ELSE
        Fail    Período inválido: ${periodo}. Use AM ou PM.
    END
    
    Confirmar Alarme
```

---

## 3. Regras de Validação

### ✅ Asserções e Verificações

#### RN-VAL-001: Usar Keywords de Validação Apropriadas

**Regra**: Escolher keyword de asserção adequada ao tipo de validação

**Keywords Disponíveis**:

| Validação | Keyword | Quando Usar |
|-----------|---------|-------------|
| Elemento visível | `Element Should Be Visible` | Verificar se elemento aparece na tela |
| Elemento não visível | `Element Should Not Be Visible` | Verificar se elemento não aparece |
| Texto exato | `Element Text Should Be` | Validar texto exato de um elemento |
| Texto contém | `Element Should Contain Text` | Validar texto parcial |
| Igualdade | `Should Be Equal` | Comparar valores exatos |
| Verdadeiro/Falso | `Should Be True` / `Should Be False` | Validar booleanos |

**Exemplo**:
```robotframework
✅ Element Should Be Visible    ${LOCATOR_ALARME}
✅ Element Text Should Be    ${LOCATOR_TITULO}    Alarmes
✅ Should Be Equal    ${periodo}    AM
```

---

#### RN-VAL-002: Mensagens de Erro Descritivas

**Regra**: Asserções devem incluir mensagem de erro personalizada

**Formato**:
```robotframework
[Assertion Keyword]    [args]    msg=[mensagem descritiva]
```

**Exemplo Válido**:
```robotframework
✅ Should Be True    ${encontrado}
...    msg=Alarme ${hora}:${minuto} ${periodo} não foi encontrado na lista

✅ Element Should Be Visible    ${localizador}
...    msg=Botão Adicionar não está visível após 20 segundos
```

**Exemplo Inválido**:
```robotframework
❌ Should Be True    ${encontrado}
❌ Element Should Be Visible    ${localizador}
```

---

#### RN-VAL-003: Wait Before Assert

**Regra**: Sempre aguardar elemento antes de validar

**Padrão Obrigatório**:
```robotframework
Wait Until Element Is Visible    ${localizador}    timeout=[tempo]
[Validação]    ${localizador}
```

**Exemplo**:
```robotframework
✅ Wait Until Element Is Visible    ${LOCATOR_ALARME}    timeout=10s
   Element Text Should Be    ${LOCATOR_ALARME}    8:30 AM
```

**Proibido**:
```robotframework
❌ Element Text Should Be    ${LOCATOR_ALARME}    8:30 AM  # Sem wait
```

---

#### RN-VAL-004: Validação com Timeout Apropriado

**Regra**: Definir timeout adequado baseado na complexidade da ação

**Timeouts Recomendados**:

| Ação | Timeout | Justificativa |
|------|---------|---------------|
| Elemento simples | 10s | Carregamento normal |
| Após navegação | 20s | Transição de tela |
| Após ação complexa | 30s | Processamento pesado |
| Em ambiente CI | +50% | Recursos limitados |

**Exemplo**:
```robotframework
Wait Until Element Is Visible    ${LOCATOR_BOTAO}    timeout=10s
Wait Until Page Contains    Alarmes    timeout=20s
```

---

#### RN-VAL-005: Timeout Obrigatório na Abertura do Aplicativo

**Regra**: É obrigatório definir timeout ao aguardar que o aplicativo do relógio abra corretamente

**Justificativa**: A abertura do aplicativo pode variar conforme o dispositivo e estado do sistema

**Timeout Obrigatório**:
- Mínimo: 20s para abertura do aplicativo do relógio

**Exemplo Correto**:
```robotframework
✅ Abrir Aplicativo de Relógio
   Open Application    ${REMOTE_URL}    ${CAPABILITIES}
   Wait Until Element Is Visible    ${LOCATOR_TELA_PRINCIPAL}    timeout=20s
```

**Proibido**:
```robotframework
❌ Abrir Aplicativo de Relógio
   Open Application    ${REMOTE_URL}    ${CAPABILITIES}
   # Sem timeout para verificar carregamento
```

---

#### RN-VAL-006: Formato de Hora Consistente Entre Entrada e Validação

**Regra**: O formato de entrada deve ser consistente com o formato esperado na validação

**Contexto**: 
- Android pode preservar o zero à esquerda na hora se digitado dessa forma
- Para evitar falhas de validação, entrada e saída devem usar o mesmo formato

**Regra de Consistência**:
- Se entrada é "8" → validar "8:30 AM"
- Se entrada é "08" → validar "08:30 AM" ou aceitar "8:30 AM" com fallback

**Recomendação (Padrão Android)**: 
- ✅ Preferir **SEM zero à esquerda** (ex: "8", "6")
- ✅ Segue convenção padrão do Android
- ✅ Mais legível e natural
- ✅ Formato: `H:MM AM/PM` onde H é 1-12

**Exemplo Correto**:
```robotframework
*** Variables ***
${HORA_AM}                    8    # SEM zero à esquerda
${MINUTO_AM}                  30
${PERIODO_AM}                 AM
${ALARME_AM_FORMATADO}        8:30 AM    # Consistente com entrada

*** Test Cases ***
Criar Alarme no Período AM
    Quando o usuário cria um alarme para ${HORA_AM}:${MINUTO_AM} ${PERIODO_AM}
    Então o alarme ${ALARME_AM_FORMATADO} deve aparecer na lista
```

**Exemplo Incorreto**:
```robotframework
❌ ${HORA_AM}                    08    # COM zero à esquerda
   ${ALARME_AM_FORMATADO}        8:30 AM    # INCONSISTENTE - sem zero

❌ Entrada: "08:30"
   Validação: "8:30 AM"  # Pode falhar
```

**Justificativa**:
- Evita falhas por incompatibilidade de formato
- Torna testes mais previsíveis e confiáveis
- Reduz necessidade de múltiplos localizadores de fallback

---

## 4. Regras de Documentação

### 📝 Documentação de Testes e Keywords

#### RN-DOC-001: Documentation em Test Cases

**Regra**: Todo test case deve ter [Documentation] com pelo menos 2 linhas

**Conteúdo Obrigatório**:
1. O que o teste valida
2. Comportamento esperado

**Exemplo**:
```robotframework
Criar Alarme no Período AM
    [Documentation]    Valida a criação de alarme no período da manhã (AM)
    ...                Verifica se o alarme é configurado corretamente
    ...                e aparece na lista com o horário esperado
```

---

#### RN-DOC-002: Tags Obrigatórias

**Regra**: Todo test case deve ter tags descritivas

**Tags Obrigatórias**:
- Funcionalidade (ex: alarme, timer)
- Prioridade (p0, p1, p2)
- Tipo (funcional, regressao, smoke)

**Tags Opcionais**:
- Categoria específica (am, pm)
- Plataforma (android, ios)

**Exemplo**:
```robotframework
[Tags]    alarme    am    funcional    p0    android
```

---

#### RN-DOC-003: Comentários Inline Quando Necessário

**Regra**: Usar comentários para explicar lógica complexa

**Quando Usar**:
- Lógica não óbvia
- Workarounds temporários
- Explicação de valores mágicos

**Exemplo**:
```robotframework
# Aguarda 8s devido a lentidão em computadores com i7 ou inferior
Sleep    8s

# Tenta múltiplos formatos devido a diferenças regionais
FOR    ${formato}    IN    @{formatos_hora}
    # Formato pode ser "10:30 AM" ou "10:30AM"
END
```

---

## 5. Regras de Manutenibilidade

### 🔧 Facilitar Manutenção

#### RN-MAN-001: DRY - Don't Repeat Yourself

**Regra**: Não repetir código, criar keywords reutilizáveis

**Exemplo Errado**:
```robotframework
❌ Test Case 1
   Click Element    id=botao
   Wait Until Visible    id=resultado
   
❌ Test Case 2
   Click Element    id=botao
   Wait Until Visible    id=resultado
```

**Exemplo Correto**:
```robotframework
✅ Clicar e Aguardar
   [Arguments]    ${locator}
   Click Element    ${locator}
   Wait Until Visible    ${locator}_resultado

✅ Test Case 1
   Clicar e Aguardar    id=botao

✅ Test Case 2
   Clicar e Aguardar    id=botao
```

---

#### RN-MAN-002: Keywords Atômicas

**Regra**: Keywords de baixo nível devem realizar uma única ação

**Exemplo Correto**:
```robotframework
✅ Clicar em Botão Adicionar
   ${localizador}=    Obter Localizador Botão Adicionar
   Click Element    ${localizador}

✅ Inserir Hora
   [Arguments]    ${hora}
   ${localizador}=    Obter Localizador Campo Hora
   Input Text    ${localizador}    ${hora}
```

**Exemplo Errado**:
```robotframework
❌ Clicar E Inserir Dados
   Click Element    ${BOTAO}
   Input Text    ${CAMPO1}    ${valor1}
   Select From List    ${LISTA}    ${opcao}
   Click Element    ${CONFIRMAR}
```

---

#### RN-MAN-003: Centralização de Locators

**Regra**: Todos os locators devem estar centralizados em Page Objects

**Estrutura Correta**:
```robotframework
# alarm_page.robot
*** Keywords ***
Obter Localizador Botão Adicionar
    [Return]    id=com.android.deskclock:id/fab

# alarm_keywords.robot
Clicar em Adicionar Alarme
    ${localizador}=    Obter Localizador Botão Adicionar
    Click Element    ${localizador}
```

**Proibido**:
```robotframework
❌ # test_alarm.robot
   Click Element    id=com.android.deskclock:id/fab
```

---

#### RN-MAN-004: Variáveis para Valores Reutilizáveis

**Regra**: Valores usados múltiplas vezes devem ser variáveis

**Exemplo Correto**:
```robotframework
*** Variables ***
${TIMEOUT_PADRAO}     20s
${HORA_AM}            08
${MINUTO_AM}          30

*** Test Cases ***
Teste 1
    Wait Until Visible    ${LOCATOR}    ${TIMEOUT_PADRAO}
    Criar Alarme    ${HORA_AM}    ${MINUTO_AM}
```

**Exemplo Errado**:
```robotframework
❌ Teste 1
   Wait Until Visible    ${LOCATOR}    20s
   Criar Alarme    08    30

❌ Teste 2
   Wait Until Visible    ${LOCATOR}    20s
   Criar Alarme    08    30
```

---

#### RN-MAN-005: Try-Except para Ações Frágeis

**Regra**: Usar `Run Keyword And Return Status` para ações que podem falhar

**Exemplo**:
```robotframework
Fechar Popup Se Existir
    ${popup_aberto}=    Run Keyword And Return Status
    ...    Element Should Be Visible    ${LOCATOR_POPUP}
    
    IF    ${popup_aberto}
        Click Element    ${LOCATOR_FECHAR_POPUP}
    END
    
    Log    Popup ${popup_aberto and 'fechado' or 'não estava aberto'}
```

---

## 📊 Checklist de Validação de Regras

Use este checklist ao revisar testes:

### Nomenclatura
- [ ] Test cases têm nomes descritivos em português
- [ ] Keywords usam verbos no infinitivo
- [ ] Variáveis estão em MAIÚSCULAS
- [ ] Arquivos seguem padrão snake_case

### Estruturação
- [ ] Projeto dividido em 3 camadas (tests/keywords/pages)
- [ ] Settings na ordem correta
- [ ] Test cases seguem estrutura BDD
- [ ] Keywords têm [Documentation]

### Validação
- [ ] Keywords de asserção apropriadas
- [ ] Mensagens de erro descritivas
- [ ] Waits antes de validações
- [ ] Timeouts adequados

### Documentação
- [ ] [Documentation] em test cases
- [ ] [Tags] obrigatórias presentes
- [ ] Comentários em lógica complexa

### Manutenibilidade
- [ ] Sem código duplicado
- [ ] Keywords atômicas
- [ ] Locators centralizados
- [ ] Variáveis para valores reutilizáveis

---

## 📚 Referências

- [PRD.md](PRD.md): Requisitos do produto
- [SDD.md](SDD.md): Design técnico
- [Test-Patterns.md](Test-Patterns.md): Padrões de implementação
- [Robot-Conventions.md](Robot-Conventions.md): Convenções do Robot Framework
- [Robot Framework Style Guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#style-guide)
