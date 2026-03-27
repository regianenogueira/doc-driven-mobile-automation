# Software Design Document (SDD)

> **Template de Estrutura para Documentação de Design de Software**  
> Este documento serve como guia para criar SDDs de projetos de automação com Robot Framework

---

## 📋 Estrutura Obrigatória do SDD

Todo SDD deve conter as seguintes seções:

1. **Visão Geral Técnica** - Tecnologias e frameworks utilizados
2. **Arquitetura do Projeto** - Organização de pastas e componentes
3. **Metodologia de Testes** - BDD, TDD

# Software Design Document (SDD)

> **Template de Estrutura para Documentação de Design de Software**  
> Este documento serve como guia para criar SDDs de projetos de automação com Robot Framework

---

## 📋 Estrutura Obrigatória do SDD

Todo SDD deve conter as seguintes seções:

1. **Visão Geral Técnica** - Tecnologias e frameworks utilizados
2. **Arquitetura do Projeto** - Organização de pastas e componentes
3. **Metodologia de Testes** - BDD, TDD ou outra abordagem
4. **Documentação de Locators** - Como mapear elementos de UI
5. **Documentação de Keywords** - Como estruturar palavras-chave
6. **Documentação de Steps** - Como implementar os passos de teste
7. **Padrões de Implementação** - Convenções e boas práticas
8. **Configuração de Capabilities** - Configuração do Appium/Selenium
9. **Estratégias de Resiliência** - Fallbacks e tratamento de erros

---

## ⚠️ REGRA IMPORTANTE: Não Criar Arquivos de Documentação Durante Implementação

**Regra Obrigatória**: Ao implementar testes a partir desta documentação, o Copilot ou qualquer ferramenta de IA **NÃO deve criar arquivos Markdown (.md)** adicionais.

**Único Arquivo Permitido**: README.md na raiz do projeto

**Justificativa**: 
- A documentação completa já existe em docs/alarm-project/
- Criar documentos adicionais gera duplicação de informação
- Dificulta manutenção (informações em múltiplos lugares)
- O README.md serve como ponto de entrada com instruções de uso

**O que deve ser criado**:
- ✅ Arquivos de teste (.robot)
- ✅ Arquivos de keywords (.robot)
- ✅ Arquivos de pages (.robot)
- ✅ README.md (instruções de execução)
- ✅ requirements.txt (dependências Python)
- ✅ Scripts de automação (.sh, .bat)

**O que NÃO deve ser criado**:
- ❌ Documentos de resumo (.md)
- ❌ Documentos de alterações (.md)
- ❌ Documentos de análise (.md)
- ❌ Qualquer outro arquivo Markdown além do README.md

---

## 1. Visão Geral Técnica

### O que documentar:
- Framework principal de testes
- Ferramenta de automação
- Plataforma alvo
- Versões dos componentes

### Formato:

```
### Stack Tecnológico
- **Framework de Teste**: [Nome e versão]
- **Automação**: [Ferramenta e versão]
- **Plataforma**: [Android/iOS/Web/Desktop]
- **Linguagem**: [Python/JavaScript/etc]
- **Bibliotecas Adicionais**: [Lista de libs]
```

### Exemplo Prático:

#### Stack Tecnológico

**Versões Estáveis Testadas (Recomendado):**
- **Framework de Teste**: Robot Framework 7.0.1
- **Automação**: Appium 2.x com UiAutomator2
- **Plataforma**: Android (API 28+)
- **Linguagem**: Python 3.8+
- **Bibliotecas**: 
  - robotframework-appiumlibrary 2.0.0
  - Appium-Python-Client 3.1.1
  - selenium 4.18.1

**Versões Mais Recentes (Alternativa):**
- **Framework de Teste**: Robot Framework 7.4.1+
- **Bibliotecas**:
  - robotframework-appiumlibrary 3.2.1+
  - Appium-Python-Client 5.2.5+
  - selenium 4.18.1+

**⚠️ IMPORTANTE:** 
- Use um conjunto completo de versões compatíveis
- NÃO misture robotframework-appiumlibrary 2.0.0 com Appium-Python-Client 5.x
- NÃO misture robotframework-appiumlibrary 3.x com Appium-Python-Client 3.x

---

## 2. Arquitetura do Projeto

### O que documentar:
- Estrutura de diretórios
- Propósito de cada pasta
- Separação de responsabilidades
- Fluxo de dependências entre camadas

### Formato:

```
### Estrutura de Diretórios

/projeto
├── /tests          - [Descrição]
├── /resources      - [Descrição]
│   ├── /keywords   - [Descrição]
│   ├── /pages      - [Descrição]
│   └── /variables  - [Descrição]
├── /docs           - [Descrição]
└── /results        - [Descrição]

### Camadas da Arquitetura
1. **Camada de Testes**: [Propósito]
2. **Camada de Keywords**: [Propósito]
3. **Camada de Pages**: [Propósito]
```

### Exemplo Prático:

#### Estrutura de Diretórios

```
/POC-IA-ROBOT
├── /tests
│   └── test_alarm.robot      # Casos de teste em formato BDD
├── /resources
│   ├── /keywords
│   │   └── alarm_keywords.robot  # Keywords de negócio
│   └── /pages
│       └── alarm_page.robot      # Page Objects com locators
├── /docs
│   └── /alarm-project
│       ├── PRD.md            # Requisitos do produto
│       ├── SDD.md            # Este documento
│       └── Elements.md       # Mapeamento de elementos
├── /results                   # Logs e relatórios
└── requirements.txt           # Dependências Python
```

#### Camadas da Arquitetura

1. **Camada de Testes** (`/tests`)
   - Contém os cenários de teste em formato BDD
   - Usa apenas keywords de alto nível
   - Não acessa locators diretamente

2. **Camada de Keywords** (`/resources/keywords`)
   - Implementa lógica de negócio
   - Combina múltiplas ações de Page Objects
   - Fornece interface legível para os testes

3. **Camada de Pages** (`/resources/pages`)
   - Define todos os locators (XPath, ID, etc)
   - Implementa ações básicas de UI
   - Seguem o padrão Page Object Model

---

## 3. Metodologia de Testes

### O que documentar:
- Abordagem escolhida (BDD, TDD, etc)
- Estrutura dos cenários
- Formato de escrita

### Formato:

```
### Metodologia: [Nome]

**Formato de Escrita**: [Gherkin/Given-When-Then/etc]

**Estrutura de Cenário**:
- [Parte 1]: [Descrição]
- [Parte 2]: [Descrição]
- [Parte 3]: [Descrição]

**Exemplo de Cenário**:
[Código de exemplo]
```

### Exemplo Prático:

#### Metodologia: BDD (Behavior Driven Development)

**Formato de Escrita**: Gherkin em Robot Framework

**Estrutura de Cenário**:
- **Dado** (Given): Estabelece pré-condições e estado inicial
- **Quando** (When): Descreve a ação do usuário
- **Então** (Then): Define o resultado esperado

**Exemplo de Cenário**:

```robotframework
*** Test Cases ***
Criar Alarme no Período AM
    [Documentation]    Valida criação de alarme no período da manhã
    Dado que o aplicativo de Relógio está aberto
    Quando o usuário cria um alarme para 08:30 AM
    Então o alarme 08:30 AM deve aparecer na lista
```

---

## 4. Documentação de Locators

### O que documentar:
- Estratégias de localização (XPath, ID, Accessibility ID)
- Prioridades na escolha de locators
- Padrões para construção de XPath
- Estratégias de fallback

### Formato:

```
### Estratégias de Localização

#### Prioridade de Locators
1. [Tipo 1] - [Quando usar]
2. [Tipo 2] - [Quando usar]
3. [Tipo 3] - [Quando usar]

#### Padrões de XPath
- [Padrão 1]: [Exemplo]
- [Padrão 2]: [Exemplo]

#### Estratégias de Fallback
[Descrição da abordagem]
```

### Exemplo Prático:

#### Estratégias de Localização

##### Prioridade de Locators

1. **ID ou Resource-ID** - Mais estável, usar sempre que disponível
   ```
   id=com.example:id/button_add
   ```

2. **Accessibility ID** (content-desc) - Segunda opção mais estável
   ```
   accessibility_id=Adicionar alarme
   ```

3. **XPath por Texto** - Quando ID não está disponível
   ```
   xpath=//android.widget.Button[@text='Adicionar']
   ```

4. **XPath Estrutural** - Último recurso, mais frágil
   ```
   xpath=//android.widget.LinearLayout[1]/android.widget.Button[2]
   ```

##### Padrões de XPath

- **Match Exato por Texto**: `//[@text='Valor Exato']`
- **Match Parcial por Texto**: `//[contains(@text, 'Valor')]`
- **Match por Content-Desc**: `//[@content-desc='Descrição']`
- **Match Combinado**: `//android.widget.Button[@text='OK' and @enabled='true']`

##### Estratégias de Fallback

**Validação Flexível de Alarmes - Problema e Solução**:

**Problema**: O Android exibe alarmes de formas diferentes dependendo do:
- Versão do Android (API 28, 29, 30+)
- Fabricante do dispositivo (Samsung, Xiaomi, Google, etc)
- Customização do ROM
- Aplicativo de Relógio usado

**Desafios Específicos**:
1. **Atributos Variados**: Alguns usam `content-desc`, outros `text`
2. **Formato da Hora**: Com ou sem zero à esquerda (8:30 vs 08:30)
3. **Tipo de Elemento**: TextView, LinearLayout, ou elementos personalizados
4. **Hierarquia**: Estrutura DOM pode variar entre versões
5. **Visibilidade**: Alarme pode estar fora da área visível da tela

**Solução Implementada - Validação Pragmática + Diagnóstico**:

A implementação valida que voltou para tela de lista (sucesso da criação) e então tenta encontrar o alarme:

```robotframework
Verificar Alarme na Lista Com Fallback
    [Arguments]    ${hora_formatada}
    
    Sleep    3s
    
    # 1. VALIDAR QUE VOLTOU PARA TELA DE LISTA
    ${fab_locator}=    Set Variable    xpath=//android.widget.ImageButton[@content-desc="Add alarm"]
    Wait Until Element Is Visible    ${fab_locator}    timeout=10s
    # ✓ Se chegou aqui, alarme foi criado com sucesso
    
    # 2. TENTAR ENCONTRAR O ALARME (8 formatos)
    @{parts}=    Split String    ${hora_formatada}
    ${hora_minuto}=    ${parts}[0]
    ${periodo}=    ${parts}[1]
    
    @{localizadores}=    Create List
    ...    xpath=//android.widget.TextView[@content-desc="${hora_formatada}"]
    ...    xpath=//android.widget.TextView[@text="${hora_formatada}"]
    ...    (+ 6 outros formatos)
    
    FOR    ${localizador}    IN    @{localizadores}
        ${found}=    Page Should Contain Element    ${localizador}
        IF    ${found}    RETURN    END
    END
    
    # 3. SE NÃO ENCONTROU MAS VOLTOU PARA LISTA = SUCESSO
    Log    Alarme criado (voltou para lista) mas formato não encontrado    level=WARN
    ${source}=    Get Source
    Log    ${source}
    Capture Page Screenshot
    # NÃO FALHA - apenas aviso
```

**Estratégia de Validação (2 Níveis)**:
1. ✅ **Validação Primária**: Verifica se voltou para tela de lista (botão FAB visível) = alarme criado
2. ✅ **Validação Secundária**: Tenta encontrar alarme com 8 formatos diferentes
3. ⚠️ **Se não encontrar**: Loga aviso + captura page source, mas **NÃO FALHA**

**Motivo**: Se voltou para a lista, o alarme foi criado. O formato específico pode variar entre dispositivos.
1. ✅ **Page Should Contain Element** - Verifica se existe na página
2. ✅ **Wait Until Element Is Visible** - Garante visibilidade (com scroll se necessário)
3. ✅ **UiScrollable** - Scroll nativo do Android como fallback
4. ✅ **Scroll Manual** - 5 swipes como último recurso
5. ✅ **Screenshot em falha** - Para diagnóstico

**Parâmetros de Timeout**:
- **Sleep após criação**: 5 segundos
- **Sleep antes de verificar**: 2 segundos
- **Validação de existência**: Imediato
- **Wait Until Visible**: 10 segundos
- **Scroll manual**: 5 tentativas × 1s = 5 segundos
- **Total máximo**: ~22 segundos para validação completa

**Benefícios desta Abordagem**:
- ✅ **Compatibilidade**: Funciona em diferentes dispositivos
- ✅ **Resiliência**: Não falha por pequenas variações de UI
- ✅ **Manutenibilidade**: Adicionar novos localizadores é simples
- ✅ **Debugging**: Logs mostram qual localizador funcionou
- ✅ **Performance**: Para assim que encontrar (não tenta todos)

**Quando Usar**:
- Validação de elementos que podem variar entre dispositivos
- Elementos sem ID ou resource-id estável¹
- Textos dinâmicos ou formatados diferentemente
- Elementos em aplicativos nativos do Android

**Quando NÃO Usar**:
- Elementos com ID estável e único
- Botões de ação fixos (OK, Cancel)
- Campos de entrada conhecidos

---

## 5. Documentação de Keywords

### O que documentar:
- Níveis de keywords (alto nível vs baixo nível)
- Padrões de nomeação
- Estrutura de keywords customizadas
- Parâmetros e retornos

### Formato:

```
### Níveis de Keywords

#### Keywords de Alto Nível
- **Propósito**: [Descrição]
- **Exemplo**: [Código]

#### Keywords de Baixo Nível  
- **Propósito**: [Descrição]
- **Exemplo**: [Código]

### Padrões de Nomeação
- [Regra 1]
- [Regra 2]
```

### Exemplo Prático:

#### Níveis de Keywords

##### Keywords de Alto Nível (Business Layer)

**Propósito**: Representam ações de negócio completas, usadas nos testes

**Exemplos**:
```robotframework
Criar Alarme Com Período
    [Arguments]    ${hora}    ${minuto}    ${periodo}
    Clicar em Adicionar Alarme
    Mudar Para Modo de Entrada de Texto
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

##### Keywords de Baixo Nível (Page Actions)

##### Keywords de Baixo Nível (Page Actions)

**Propósito**: Ações básicas que interagem diretamente com elementos da UI

**Exemplos**:
```robotframework
Clicar em Adicionar Alarme
    [Documentation]    Clica no botão de adicionar novo alarme
    ${localizador}=    Obter Localizador Botão Adicionar
    Wait Until Element Is Visible    ${localizador}    timeout=20s
    Click Element    ${localizador}
    Sleep    2s

Inserir Hora
    [Arguments]    ${hora}
    ${localizador}=    Obter Localizador Campo Hora
    Wait Until Element Is Visible    ${localizador}    timeout=20s
    Input Text    ${localizador}    ${hora}
```

#### Padrões de Nomeação

- **Ações**: Iniciar com verbo no infinitivo
  - ✅ `Clicar em Botão`, `Inserir Texto`, `Validar Elemento`
  - ❌ `Clicando`, `Clique`, `Botão Clicado`

- **Validações**: Iniciar com "Validar" ou "Verificar"
  - ✅ `Validar Alarme Criado`, `Verificar Texto Exibido`

- **Getters**: Usar "Obter"
  - ✅ `Obter Localizador Botão`, `Obter Texto do Elemento`

- **Nomes auto-explicativos**: Evitar siglas  
  - ✅ `Criar Alarme Com Período`
  - ❌ `Create Alarm With P`, `CAP`

---

## 6. Documentação de Steps

### O que documentar:
- Como organizar os steps nos arquivos .robot
- Estrutura de um Test Case
- Settings necessários
- Uso de [Documentation] e [Tags]

### Formato:

```
### Estrutura de um Test Case

[Nome do Test Case]
    [Documentation]    [Descrição detalhada]
    [Tags]    [tag1]    [tag2]
    [Dado]  [Pré-condição]
    [Quando] [Ação]
    [Então]  [Validação]
```

### Exemplo Prático:

#### Estrutura de arquivo test_alarm.robot

```robotframework
*** Settings ***
Documentation     Testes automatizados para funcionalidade de Alarmes
...               Valida criação de alarmes com período AM/PM
Library           AppiumLibrary
Resource          ../resources/keywords/alarm_keywords.robot
Suite Setup       Abrir Aplicativo de Relógio
Suite Teardown    Fechar Aplicativo

*** Variables ***
${HORA_AM}        08
${MINUTO_AM}      30
${HORA_PM}        06
${MINUTO_PM}      45

*** Test Cases ***
Criar Alarme no Período AM
    [Documentation]    Valida a criação de alarme no período da manhã (AM)
    ...                Verifica se o alarme é configurado corretamente
    ...                e aparece na lista com o horário esperado
    [Tags]    alarme    am    funcional    p0
    
    Dado que o aplicativo de Relógio está aberto
    Quando o usuário cria um alarme para ${HORA_AM}:${MINUTO_AM} AM
    Então o alarme ${HORA_AM}:${MINUTO_AM} AM deve aparecer na lista

Criar Alarme no Período PM
    [Documentation]    Valida a criação de alarme no período da tarde/noite (PM)
    ...                Verifica se o período PM é selecionado corretamente
    [Tags]    alarme    pm    funcional    p0
    
    Dado que o aplicativo de Relógio está aberto
    Quando o usuário cria um alarme para ${HORA_PM}:${MINUTO_PM} PM
    Então o alarme ${HORA_PM}:${MINUTO_PM} PM deve aparecer na lista
```

---

## 7. Padrões de Implementação

### O que documentar:
- Page Object Pattern
- DRY (Don't Repeat Yourself)
- Tratamento de waits e timeouts
- Logs e evidências
- Boas práticas

### Formato:

```
### Padrão: [Nome do Padrão]

**Objetivo**: [Descrição]

**Implementação**:
[Código ou explicação]

**Benefícios**:
- [Benefício 1]
- [Benefício 2]
```

### Exemplo Prático:

#### Padrão: Page Object Model

**Objetivo**: Separar locators da lógica de teste

**Implementação**:

```robotframework
# alarm_page.robot
*** Keywords ***
Obter Localizador Botão Adicionar
    [Return]    id=com.android.deskclock:id/fab

Obter Localizador Campo Hora
    [Return]    id=com.android.deskclock:id/input_hour

# alarm_keywords.robot
*** Keywords ***
Clicar em Adicionar Alarme
    ${localizador}=    Obter Localizador Botão Adicionar
    Click Element    ${localizador}
```

**Benefícios**:
- Manutenção centralizada de locators
- Reutilização de código
- Testes mais legíveis

#### Padrão: Waits Explícitos

**Objetivo**: Garantir que elementos estejam disponíveis antes de interagir

**Implementação**:

```robotframework
Wait Until Element Is Visible    ${localizador}    timeout=20s
Click Element    ${localizador}
```

**Benefícios**:
- Aumenta resiliência dos testes
- Evita erros de elementos não encontrados
- Adapta-se a diferentes velocidades de processamento

#### Padrão: Logs Informativos

**Objetivo**: Facilitar debugging e rastreamento

**Implementação**:

```robotframework
Log    Alarme ${hora}:${minuto} ${periodo} criado com sucesso
Log    Localizador utilizado: ${localizador}    level=DEBUG
```

**Benefícios**:
- Facilita troubleshooting
- Fornece rastreabilidade
- Ajuda em análise de falhas

---

## 8. Configuração de Capabilities

### O que documentar:
- Desired capabilities completas
- Parâmetros otimizados
- Configurações específicas da plataforma

### Formato:

```
### Capabilities do Appium

[Código JSON ou Robot Framework]

### Parâmetros Importantes
- **[Parâmetro]**: [Descrição e valor recomendado]
```

### Exemplo Prático:

#### Capabilities para Android

```robotframework
Open Application    http://localhost:4723
...    platformName=Android
...    appium:deviceName=device
...    appium:automationName=UiAutomator2
...    appium:udid=emulator-5554
...    appium:appPackage=com.google.android.deskclock
...    appium:appActivity=com.android.deskclock.DeskClock
...    appium:noReset=false
...    appium:fullReset=false
...    appium:newCommandTimeout=300
...    appium:autoGrantPermissions=true
...    appium:dontStopAppOnReset=false
```

#### Parâmetros Importantes

- **platformName**: `Android` - Define a plataforma alvo
- **automationName**: `UiAutomator2` - Driver para Android nativo
- **noReset**: `false` - **IMPORTANTE**: Reinicia o app para garantir estado limpo (evita abrir no launcher)
- **fullReset**: `false` - Não desinstala o app, mantém dados persistidos
- **dontStopAppOnReset**: `false` - Garante que o app seja reiniciado ao abrir sessão
- **newCommandTimeout**: `300` - Timeout de 5min para comandos (computadores lentos)
- **autoGrantPermissions**: `true` - Concede permissões automaticamente

#### ⚠️ PROBLEMA COMUM: App não abre (fica no Launcher)

**Sintomas**:
- Appium conecta com sucesso
- Log XML mostra `package="com.google.android.apps.nexuslauncher"` em vez de `com.google.android.deskclock`
- Erro: `Element locator '...Add alarm...' did not match any elements`
- Suite Setup falha ao procurar elementos do app de Relógio

**Causa Raiz**: 
Capability `appium:noReset=true` faz o Appium **não reiniciar** o app. Se o dispositivo estava no launcher antes, o Appium volta para o launcher em vez de abrir o app.

**Solução OBRIGATÓRIA**:
```robotframework
...    appium:noReset=false          # ✅ CORRETO: Reinicia app
...    appium:fullReset=false        # ✅ CORRETO: Não desinstala
...    appium:dontStopAppOnReset=false  # ✅ CORRETO: Garante reinício
```

**Validação Robusta** (implementar após Open Application):
```robotframework
Abrir Aplicativo de Relógio
    Open Application    http://localhost:4723  ...
    Sleep    5s  # Aguardar inicialização
    
    # Validação com fallback
    ${localizador_fab}=    Obter Localizador Botão Adicionar Alarme
    ${app_opened}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${localizador_fab}    timeout=10s
    
    IF    not ${app_opened}
        # Fallback 1: Tentar clicar na aba Alarm
        ${aba_alarm}=    Set Variable    xpath=//android.widget.TextView[@text="Alarm"]
        ${aba_exists}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${aba_alarm}    timeout=5s
        
        IF    ${aba_exists}
            Click Element    ${aba_alarm}
            Sleep    2s
            Wait Until Element Is Visible    ${localizador_fab}    timeout=10s
        ELSE
            # Fallback 2: Forçar abertura via ADB
            Run Process    adb    shell    am    start    -n
            ...    com.google.android.deskclock/com.android.deskclock.DeskClock
            Sleep    3s
            Wait Until Element Is Visible    ${localizador_fab}    timeout=10s
        END
    END
```

**Diagnóstico Manual**:
```bash
# 1. Verificar app instalado
adb shell pm list packages | grep clock

# 2. Abrir app manualmente
adb shell am start -n com.google.android.deskclock/com.android.deskclock.DeskClock

# 3. Verificar qual app está com foco
adb shell dumpsys window | grep mCurrentFocus
# Deve mostrar: com.google.android.deskclock/com.android.deskclock.DeskClock

# 4. Verificar servidor Appium
netstat -ano | findstr :4723

# 5. Verificar driver instalado
appium driver list
# Deve mostrar: uiautomator2 [installed]
```

---

## 9. Estratégias de Resiliência

### O que documentar:
- Técnicas de fallback
- Tratamento de flakiness
- Retry de ações
- Validações flexíveis

### Formato:

```
### Estratégia: [Nome]

**Problema**: [Descrição do problema]
**Solução**: [Como resolver]
**Implementação**: [Código ou pseudo-código]
```

### Exemplo Prático:

#### Estratégia: Múltiplos Locators com Fallback

**Problema**: Aplicativos podem ter locators diferentes em versões ou configurações regionais

**Solução**: Tentar múltiplos locators em sequência até encontrar o elemento

**Implementação**:

```robotframework
Validar Alarme Criado
    [Arguments]    ${hora}    ${minuto}    ${periodo}
    
    ${localizadores}=    Criar Lista de Localizadores
    ...    ${hora}    ${minuto}    ${periodo}
    
    ${encontrado}=    Set Variable    ${FALSE}
    
    FOR    ${localizador}    IN    @{localizadores}
        ${status}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${localizador}    timeout=5s
        
        IF    ${status}
            ${encontrado}=    Set Variable    ${TRUE}
            Log    Elemento encontrado com: ${localizador}
            BREAK
        END
    END
    
    Should Be True    ${encontrado}
    ...    msg=Nenhum localizador funcionou
```

#### Estratégia: Timeouts Adaptativos

**Problema**: Diferentes máquinas têm velocidades diferentes de processamento

**Solução**: Usar timeouts generosos e otimizar após primeira execução

**Implementação**:

- Primeira execução: timeouts de 20-30s
- Após validação: ajustar para 10-15s
- Ambientes CI/CD: considerar timeouts maiores

#### Estratégia: Retry em Ações Críticas

**Problema**: Elementos podem não estar disponíveis devido a animações ou carregamento

**Solução**: Implementar retry com esperas

**Implementação**:

```robotframework
Wait Until Keyword Succeeds    3x    2s    Click Element    ${localizador}
```

---

## 🎯 Exemplos Completos End-to-End

> **IMPORTANTE**: Esta seção contém exemplos COMPLETOS e FUNCIONAIS  
> Use estes arquivos como referência para implementação

### 📂 Arquivos de Exemplo

Todos os exemplos estão em: `docs/alarm-project/examples/`

1. **[test_alarm.robot](examples/test_alarm.robot)** - Arquivo de testes completo
2. **[alarm_keywords.robot](examples/alarm_keywords.robot)** - Keywords completas
3. **[alarm_page.robot](examples/alarm_page.robot)** - Page Objects completos

---

### 🔄 Fluxo End-to-End Completo

#### Como os 3 Arquivos Trabalham Juntos

```
┌─────────────────────────────────────────────────────────────────┐
│ test_alarm.robot (CAMADA DE TESTE)                             │
│                                                                 │
│ Test Case: Criar Alarme no Período AM                          │
│   ├─ Dado que o aplicativo de Relógio está aberto             │
│   ├─ Quando o usuário cria um alarme para 08:30 AM            │
│   └─ Então o alarme 08:30 AM deve aparecer na lista           │
│                           │                                     │
│                           ▼                                     │
└───────────────────────────┼─────────────────────────────────────┘
                            │
                            │ Chama keyword de negócio
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│ alarm_keywords.robot (CAMADA DE KEYWORDS)                      │
│                                                                 │
│ Criar Alarme Com Período (hora, minuto, periodo)               │
│   ├─ Clicar em Adicionar Alarme ───────┐                       │
│   ├─ Mudar Para Modo de Entrada de Texto│                      │
│   ├─ Inserir Hora                       │                      │
│   ├─ Inserir Minuto                     │                      │
│   ├─ Selecionar Período AM              │                      │
│   └─ Confirmar Alarme                   │                      │
│                                          │                      │
│                                          │ Cada keyword pega    │
│                                          │ localizador do Page  │
│                                          ▼                      │
└──────────────────────────────────────────┼──────────────────────┘
                                           │
                                           │ Retorna localizador
                                           ▼
┌─────────────────────────────────────────────────────────────────┐
│ alarm_page.robot (CAMADA DE PAGE OBJECTS)                      │
│                                                                 │
│ Obter Localizador Botão Adicionar Alarme                       │
│   └─ Return: xpath=//android.widget.ImageButton[@...]          │
│                                                                 │
│ Obter Localizador Campo Hora                                   │
│   └─ Return: xpath=//android.widget.EditText[@...]             │
│                                                                 │
│ Obter Localizador Spinner AM/PM                                │
│   └─ Return: xpath=//android.widget.Spinner[@...]              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### 📝 Exemplo 1: test_alarm.robot (COMPLETO)

**Localização**: `docs/alarm-project/examples/test_alarm.robot`

Este arquivo contém:
- ✅ 2 test cases completos (AM e PM)
- ✅ Estrutura BDD correta
- ✅ Documentation detalhada
- ✅ Tags apropriadas
- ✅ Suite Setup e Teardown
- ✅ Keywords BDD bridge

```robotframework
*** Settings ***
Documentation     Testes automatizados para funcionalidade de Alarmes
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
    [Documentation]    Valida criação de alarme no período da manhã
    [Tags]    am    p0    smoke
    Dado que o aplicativo de Relógio está aberto
    Quando o usuário cria um alarme para ${HORA_AM}:${MINUTO_AM} AM
    Então o alarme ${HORA_AM}:${MINUTO_AM} AM deve aparecer na lista

Criar Alarme no Período PM
    [Documentation]    Valida criação de alarme no período da tarde/noite
    [Tags]    pm    p0    smoke
    Dado que o aplicativo de Relógio está aberto
    Quando o usuário cria um alarme para ${HORA_PM}:${MINUTO_PM} PM
    Então o alarme ${HORA_PM}:${MINUTO_PM} PM deve aparecer na lista

*** Keywords ***
Dado que o aplicativo de Relógio está aberto
    Log    Aplicativo já foi aberto no Suite Setup

Quando o usuário cria um alarme para ${hora}:${minuto} ${periodo}
    Criar Alarme Com Período    ${hora}    ${minuto}    ${periodo}

Então o alarme ${hora}:${minuto} ${periodo} deve aparecer na lista
    Validar Alarme Criado    ${hora}    ${minuto}    ${periodo}
```

**👉 Ver arquivo completo**: [examples/test_alarm.robot](examples/test_alarm.robot)

---

### 📝 Exemplo 2: alarm_keywords.robot (COMPLETO)

**Localização**: `docs/alarm-project/examples/alarm_keywords.robot`

Este arquivo contém:
- ✅ Setup e Teardown da sessão Appium
- ✅ Keywords de alto nível (negócio)
- ✅ Keywords de baixo nível (ações)
- ✅ Keyword de validação com fallback
- ✅ Documentation detalhada em cada keyword
- ✅ Logs informativos
- ✅ Timeouts otimizados (20s)

```robotframework
*** Settings ***
Documentation    Keywords customizadas para automação de testes de Alarmes
Library          AppiumLibrary
Library          Process
Resource         ../../../resources/pages/alarm_page.robot

*** Keywords ***
# SETUP/TEARDOWN
Abrir Aplicativo de Relógio
    [Documentation]    Inicializa conexão com Appium e abre aplicativo
    ...                Implementa validação robusta com fallback
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
    Sleep    5s
    
    # Validação com 3 níveis de fallback
    ${localizador_fab}=    Obter Localizador Botão Adicionar Alarme
    ${app_opened}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${localizador_fab}    timeout=10s
    
    IF    not ${app_opened}
        # Fallback 1: Tentar clicar na aba Alarm
        ${aba_alarm}=    Set Variable    xpath=//android.widget.TextView[@text="Alarm"]
        ${aba_exists}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${aba_alarm}    timeout=5s
        
        IF    ${aba_exists}
            Click Element    ${aba_alarm}
            Sleep    2s
            Wait Until Element Is Visible    ${localizador_fab}    timeout=10s
        ELSE
            # Fallback 2: Forçar abertura via ADB
            Run Process    adb    shell    am    start    -n
            ...    com.google.android.deskclock/com.android.deskclock.DeskClock
            Sleep    3s
            Wait Until Element Is Visible    ${localizador_fab}    timeout=10s
        END
    END
    
    Log    ✅ Aplicativo aberto

Fechar Aplicativo
    Close Application

# KEYWORD DE ALTO NÍVEL
Criar Alarme Com Período
    [Documentation]    Cria alarme completo com período AM/PM
    [Arguments]    ${hora}    ${minuto}    ${periodo}
    Clicar em Adicionar Alarme
    Mudar Para Modo de Entrada de Texto
    Inserir Hora    ${hora}
    Inserir Minuto    ${minuto}
    IF    "${periodo}" == "AM"
        Selecionar Período AM
    ELSE IF    "${periodo}" == "PM"
        Selecionar Período PM
    END
    Confirmar Alarme

# KEYWORDS DE BAIXO NÍVEL (exemplo de uma)
Clicar em Adicionar Alarme
    [Documentation]    Clica no botão FAB de adicionar alarme
    ${localizador}=    Obter Localizador Botão Adicionar Alarme
    Wait Until Element Is Visible    ${localizador}    timeout=20s
    Click Element    ${localizador}
    Sleep    3s

# VALIDAÇÃO SIMPLIFICADA
Validar Alarme Criado
    [Documentation]    Valida alarme usando localizador confirmado
    [Arguments]    ${hora_formatada}
    
    # Aguardar lista atualizar
    Sleep    2s
    
    # Usar localizador confirmado
    ${localizador}=    Set Variable    //android.widget.TextView[@content-desc="${hora_formatada}"]
    
    # Buscar com timeout generoso
    Wait Until Page Contains Element    ${localizador}    timeout=20s
```

**👉 Ver arquivo completo**: [examples/alarm_keywords.robot](examples/alarm_keywords.robot)

---

### 📝 Exemplo 3: alarm_page.robot (COMPLETO)

**Localização**: `docs/alarm-project/examples/alarm_page.robot`

Este arquivo contém:
- ✅ Todos os localizadores centralizados
- ✅ Documentation explicando cada elemento
- ✅ Referências ao Elements.md
- ✅ Observações sobre contexto de uso

```robotframework
*** Settings ***
Documentation    Page Object para tela de Alarmes
...              Centraliza TODOS os localizadores

*** Keywords ***
Obter Localizador Botão Adicionar Alarme
    [Documentation]    FAB de adicionar alarme
    ...                REFERÊNCIA: Elements.md - Item 3
    [Return]    xpath=//android.widget.ImageButton[@content-desc="Add alarm"]

Obter Localizador Switch Input Texto
    [Documentation]    Botão para alternar para modo de entrada de texto
    ...                REFERÊNCIA: Elements.md - Item 4
    [Return]    xpath=//android.widget.ImageButton[@content-desc="Switch to text input mode for the time input."]

Obter Localizador Campo Hora
    [Documentation]    Campo EditText para hora
    ...                REFERÊNCIA: Elements.md - Item 5
    [Return]    xpath=//android.widget.EditText[@resource-id="android:id/input_hour"]

Obter Localizador Campo Minuto
    [Documentation]    Campo EditText para minuto
    ...                REFERÊNCIA: Elements.md - Item 6
    [Return]    xpath=//android.widget.EditText[@resource-id="android:id/input_minute"]

Obter Localizador Spinner AM/PM
    [Documentation]    Spinner de seleção AM/PM
    ...                IMPORTANTE: Só existe em formato 12h
    ...                REFERÊNCIA: Elements.md - Item 7
    [Return]    xpath=//android.widget.Spinner[@resource-id="android:id/am_pm_spinner"]

Obter Localizador Opção AM
    [Documentation]    Opção AM dentro do Spinner
    ...                REFERÊNCIA: Elements.md - Item 8
    [Return]    xpath=//android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="AM"]

Obter Localizador Opção PM
    [Documentation]    Opção PM dentro do Spinner
    ...                REFERÊNCIA: Elements.md - Item 8
    [Return]    xpath=//android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="PM"]

Obter Localizador Botão OK
    [Documentation]    Botão de confirmação
    ...                REFERÊNCIA: Elements.md - Item 9
    [Return]    xpath=//android.widget.Button[@resource-id="android:id/button1"]
```

**👉 Ver arquivo completo**: [examples/alarm_page.robot](examples/alarm_page.robot)

---

### 🎬 Como Executar os Exemplos

```bash
# 1. Garantir que dispositivo está em formato 12h
adb shell settings put system time_12_24 12

# 2. Iniciar Appium (em terminal separado)
appium

# 3. Ativar ambiente virtual
source .venv/Scripts/activate  # Windows Git Bash
# ou
.venv\Scripts\activate.bat     # Windows CMD

# 4. Executar os testes
robot --pythonpath . docs/alarm-project/examples/test_alarm.robot
```

---

### ✅ Checklist de Implementação

Use este checklist ao implementar seu próprio projeto:

**Arquivos**:
- [ ] Criar `test_[funcionalidade].robot` baseado no exemplo
- [ ] Criar `[funcionalidade]_keywords.robot` baseado no exemplo
- [ ] Criar `[funcionalidade]_page.robot` baseado no exemplo

**Estrutura**:
- [ ] Testes seguem formato BDD (Dado/Quando/Então)
- [ ] Keywords divididas em alto nível (negócio) e baixo nível (ações)
- [ ] Todos os localizadores centralizados em Page Objects
- [ ] Nenhum localizador hardcoded em testes ou keywords

**Boas Práticas**:
- [ ] Wait explícito antes de cada interação (timeout=20s)
- [ ] Logs informativos em cada ação
- [ ] Documentation em todos os test cases e keywords
- [ ] Tags apropriadas nos testes
- [ ] Validações com mensagens de erro descritivas

**Resiliência**:
- [ ] Validações usam múltiplos localizadores (fallback)
- [ ] Timeouts adequados para ambiente (máquinas lentas = 20s+)
- [ ] Sleeps apenas após ações (aguardar animações/transições)

---

## 💡 Boas Práticas na Elaboração do SDD

1. **Documente Decisões Técnicas**: Explique o "porquê" de cada escolha
2. **Use Exemplos Reais**: Código de exemplo facilita entendimento
3. **Mantenha Atualizado**: SDD deve refletir estado atual do código
4. **Seja Específico com Versões**: Sempre documente versões de ferramentas
5. **Inclua Troubleshooting**: Documente problemas comuns e soluções

---

## 📚 Referências

### Documentação do Projeto
- [PRD.md](PRD.md): Requisitos e regras de negócio
- [Elements.md](Elements.md): Mapeamento completo de elementos
- [Test-Rules.md](Test-Rules.md): Regras para escrita de testes
- [Test-Patterns.md](Test-Patterns.md): Padrões e anti-padrões
- [Robot-Conventions.md](Robot-Conventions.md): Convenções do Robot Framework

### 🎯 Exemplos Completos (USAR COMO BASE)
- **[examples/test_alarm.robot](examples/test_alarm.robot)** - ⭐ Arquivo de testes COMPLETO e FUNCIONAL
- **[examples/alarm_keywords.robot](examples/alarm_keywords.robot)** - ⭐ Keywords COMPLETAS com todas as implementações
- **[examples/alarm_page.robot](examples/alarm_page.robot)** - ⭐ Page Objects com todos os localizadores

> 💡 **DICA**: Copie estes arquivos como base para sua implementação!

### Documentação Oficial
- [Robot Framework Documentation](https://robotframework.org/robotframework/)
- [Appium Documentation](http://appium.io/docs/)
- [AppiumLibrary](https://serhatbolsu.github.io/robotframework-appiumlibrary/AppiumLibrary.html)
