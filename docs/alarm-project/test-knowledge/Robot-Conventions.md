# Robot Framework Conventions

> **Guia Completo de Convenções e Boas Práticas do Robot Framework**  
> Sintaxe, estrutura de projeto, execução e troubleshooting

---

## 📋 Tópicos Obrigatórios

Este documento cobre:

1. **Sintaxe do Robot Framework** - Regras de escrita e formato
2. **Estrutura de Projeto** - Organização de arquivos e pastas
3. **Boas Práticas** - Convenções recomendadas
4. **Configuração de Ambiente** - Setup e pré-requisitos
5. **Execução de Testes** - Comandos e opções
6. **Troubleshooting** - Problemas comuns e soluções

---

## 1. Sintaxe do Robot Framework

### 📝 Seções do Arquivo .robot

Todo arquivo Robot Framework pode conter até 4 seções na seguinte ordem:

```robotframework
*** Settings ***
# Imports, setup, teardown

*** Variables ***
# Variáveis globais do arquivo

*** Test Cases ***
# Cenários de teste

*** Keywords ***
# Keywords customizadas
```

**Regras**:
- Nomes de seções são case-insensitive
- Seções são opcionais (exceto Test Cases em arquivos de teste)
- Ordem deve ser respeitada
- Usar `***` ou `*` antes e depois do nome da seção

---

### 🔤 Separadores e Indentação

#### Separadores

Robot Framework usa **espaços** como separadores (mínimo 2 espaços):

```robotframework
# ✅ CORRETO - 4 espaços entre colunas
Click Element    ${LOCATOR}    timeout=10s

# ✅ CORRETO - Tabs (convertidos para espaços)
Click Element	${LOCATOR}	timeout=10s

# ❌ ERRADO - 1 espaço apenas
Click Element ${LOCATOR} timeout=10s
```

**Recomendação**: Use **4 espaços** entre colunas para melhor legibilidade

---

#### Indentação

Keywords dentro de estruturas de controle devem ser indentadas:

```robotframework
*** Keywords ***
Processar Items
    FOR    ${item}    IN    @{lista}
        Log    Processando ${item}
        
        IF    "${item}" == "especial"
            Ação Especial    ${item}
        ELSE
            Ação Normal    ${item}
        END
    END
```

**Recomendação**: Use **4 espaços** para cada nível de indentação

---

### 📦 Settings (Configurações)

#### Settings em Arquivos de Teste

```robotframework
*** Settings ***
Documentation     Testes automatizados para Alarmes
...               Valida criação e edição de alarmes
...               Requer dispositivo Android em formato 12h

Library           AppiumLibrary
Library           Collections
Library           String

Resource          ../resources/keywords/alarm_keywords.robot
Resource          ../resources/pages/alarm_page.robot
Resource          ../resources/common/variables.robot

Suite Setup       Abrir Aplicativo de Relógio
Suite Teardown    Fechar Aplicativo

Test Setup        Preparar Teste
Test Teardown     Finalizar Teste

Test Tags         alarme    android
Test Timeout      2 minutes

Default Tags      regressao
```

#### Settings Importantes

| Setting | Descrição | Exemplo |
|---------|-----------|---------|
| `Documentation` | Descrição do arquivo/suite | `Documentation    Testes de Alarme` |
| `Library` | Importa biblioteca | `Library    AppiumLibrary` |
| `Resource` | Importa arquivo de recursos | `Resource    keywords.robot` |
| `Suite Setup` | Executado uma vez antes de todos os testes | `Suite Setup    Abrir App` |
| `Suite Teardown` | Executado uma vez após todos os testes | `Suite Teardown    Fechar App` |
| `Test Setup` | Executado antes de cada teste | `Test Setup    Limpar Dados` |
| `Test Teardown` | Executado após cada teste | `Test Teardown    Screenshot` |
| `Test Tags` | Tags aplicadas a todos os testes | `Test Tags    smoke` |
| `Test Timeout` | Timeout padrão para testes | `Test Timeout    5 minutes` |

---

### 🔢 Variables (Variáveis)

#### Declaração de Variáveis

```robotframework
*** Variables ***
# Variáveis escalares (single value)
${TIMEOUT_PADRAO}         20s
${HORA_AM}                08
${MINUTO_AM}              30
${APP_PACKAGE}            com.google.android.deskclock

# Variáveis de lista (multiple values)
@{PERIODOS}               AM    PM
@{HORARIOS_TESTE}         08:30    12:00    18:45

# Variáveis de dicionário (key-value pairs)
&{ALARME_AM}              hora=08    minuto=30    periodo=AM
&{CAPABILITIES}           platformName=Android    deviceName=device
```

#### Uso de Variáveis

```robotframework
*** Test Cases ***
Exemplo de Uso
    # Variável escalar
    Log    ${HORA_AM}
    
    # Item de lista por índice
    Log    ${PERIODOS}[0]    # AM
    
    # Itens de lista
    Log Many    @{PERIODOS}    # AM PM
    
    # Item de dicionário
    Log    ${ALARME_AM}[hora]    # 08
    
    # Dicionário como keyword arguments
    Criar Alarme    &{ALARME_AM}
```

---

### 🧪 Test Cases (Casos de Teste)

#### Estrutura Básica

```robotframework
*** Test Cases ***
Nome do Test Case
    [Documentation]    Descrição do teste
    ...                Pode ter múltiplas linhas
    [Tags]    tag1    tag2    tag3
    [Setup]    Preparação Específica Deste Teste
    [Timeout]    1 minute
    
    # Steps do teste
    Keyword 1
    Keyword 2    arg1    arg2
    Keyword 3
    
    [Teardown]    Limpeza Específica Deste Teste
```

#### Test Case Settings

| Setting | Descrição |
|---------|-----------|
| `[Documentation]` | Descrição do teste |
| `[Tags]` | Tags para filtrar execução |
| `[Setup]` | Executado antes deste teste específico |
| `[Teardown]` | Executado após este teste específico |
| `[Timeout]` | Timeout para este teste específico |
| `[Template]` | Define template para data-driven testing |

#### Exemplo Completo

```robotframework
*** Test Cases ***
Criar Alarme no Período AM
    [Documentation]    Valida a criação de alarme no período da manhã
    ...                Verifica se o alarme é salvo corretamente
    ...                e aparece na lista com horário correto
    [Tags]    alarme    am    funcional    p0    smoke
    [Setup]    Limpar Alarmes Existentes
    [Timeout]    3 minutes
    
    Dado que o aplicativo de Relógio está aberto
    Quando o usuário cria um alarme para 08:30 AM
    Então o alarme 08:30 AM deve aparecer na lista
    E o alarme deve estar ativo
    
    [Teardown]    Capturar Screenshot Se Falhar
```

---

### 🔧 Keywords (Palavras-chave)

#### Estrutura de Keyword

```robotframework
*** Keywords ***
Nome da Keyword
    [Documentation]    Descrição do que a keyword faz
    ...                Informações adicionais
    [Arguments]    ${arg1}    ${arg2}=${valor_padrao}
    [Tags]    tag1    tag2
    [Timeout]    30s
    
    # Implementação
    Log    Processando ${arg1}
    ${resultado}=    Processar    ${arg1}    ${arg2}
    
    [Return]    ${resultado}
```

#### Keyword Settings

| Setting | Descrição |
|---------|-----------|
| `[Documentation]` | Descrição da keyword |
| `[Arguments]` | Define parâmetros de entrada |
| `[Tags]` | Tags da keyword |
| `[Timeout]` | Timeout para a keyword |
| `[Return]` | Valor(es) de retorno |

#### Tipos de Arguments

```robotframework
*** Keywords ***
Exemplo de Argumentos
    # Argumentos obrigatórios
    [Arguments]    ${arg_obrigatorio}
    
    # Argumentos com valor padrão
    [Arguments]    ${arg}=${valor_padrao}
    
    # Argumentos variáveis (*args)
    [Arguments]    @{multiplos_args}
    
    # Combinação
    [Arguments]    ${obrigatorio}    ${opcional}=default    @{resto}
    
    # Keyword arguments (**kwargs)
    [Arguments]    &{kwargs}
```

#### Exemplo Prático

```robotframework
*** Keywords ***
Criar Alarme Com Período
    [Documentation]    Cria um alarme completo com hora, minuto e período
    ...                Combina todas as ações necessárias
    ...                Retorna True se sucesso, False se falha
    [Arguments]    ${hora}    ${minuto}    ${periodo}
    [Tags]    alarme    acao
    [Timeout]    1 minute
    
    Log    Iniciando criação de alarme ${hora}:${minuto} ${periodo}
    
    Clicar em Botão Adicionar
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
    
    ${sucesso}=    Run Keyword And Return Status
    ...    Validar Alarme Criado    ${hora}    ${minuto}    ${periodo}
    
    RETURN    ${sucesso}
```

---

### 🔄 Estruturas de Controle

#### IF / ELSE IF / ELSE

```robotframework
*** Keywords ***
Processar Baseado em Condição
    [Arguments]    ${valor}
    
    IF    ${valor} > 100
        Log    Valor alto
    ELSE IF    ${valor} > 50
        Log    Valor médio
    ELSE
        Log    Valor baixo
    END
```

#### FOR Loop

```robotframework
*** Keywords ***
Processar Lista
    [Arguments]    @{items}
    
    FOR    ${item}    IN    @{items}
        Log    Processando: ${item}
        Processar Item    ${item}
    END

Processar Range
    FOR    ${i}    IN RANGE    10
        Log    Iteração ${i}
    END

Processar Dicionário
    FOR    ${chave}    ${valor}    IN    &{dicionario}
        Log    ${chave} = ${valor}
    END
```

#### WHILE Loop

```robotframework
*** Keywords ***
Aguardar Condição
    ${tentativas}=    Set Variable    0
    
    WHILE    ${tentativas} < 5
        ${sucesso}=    Verificar Condição
        IF    ${sucesso}
            BREAK
        END
        ${tentativas}=    Evaluate    ${tentativas} + 1
        Sleep    1s
    END
```

#### TRY / EXCEPT

```robotframework
*** Keywords ***
Tentar Ação Com Fallback
    TRY
        Ação Principal
    EXCEPT    Erro Esperado
        Log    Erro esperado ocorreu
        Ação Alternativa
    EXCEPT
        Log    Erro inesperado
        Fail    Ação falhou
    FINALLY
        Log    Sempre executado
    END
```

---

### 📝 Continuação de Linha

Quando uma linha fica muito longa, use `...`:

```robotframework
*** Settings ***
Documentation     Esta é uma documentação muito longa
...               que precisa ser quebrada em múltiplas linhas
...               para melhor legibilidade

*** Keywords ***
Keyword Com Muitos Argumentos
    [Documentation]    Exemplo de continuação de linha
    [Arguments]    ${arg1}    ${arg2}    ${arg3}
    
    ${resultado}=    Keyword Complexa
    ...    primeiro_argumento=${arg1}
    ...    segundo_argumento=${arg2}
    ...    terceiro_argumento=${arg3}
    ...    timeout=30s
    ...    retry=3
```

---

### 💬 Comentários

```robotframework
*** Test Cases ***
# Este é um comentário de linha inteira

Teste Exemplo
    # Comentário dentro do teste
    Keyword 1    # Comentário inline
    Keyword 2
    # Keyword 3    # Keyword comentada (não executa)
```

---

## 2. Estrutura de Projeto

### 📁 Organização de Diretórios

#### Estrutura Padrão

```
/projeto-automacao
├── /tests
│   ├── test_alarme.robot
│   ├── test_timer.robot
│   └── test_cronometro.robot
│
├── /resources
│   ├── /keywords
│   │   ├── alarme_keywords.robot
│   │   ├── timer_keywords.robot
│   │   └── common_keywords.robot
│   │
│   ├── /pages
│   │   ├── alarme_page.robot
│   │   ├── timer_page.robot
│   │   └── base_page.robot
│   │
│   └── /common
│       ├── variables.robot
│       └── config.robot
│
├── /docs
│   └── /alarm-project
│       ├── PRD.md
│       ├── SDD.md
│       ├── Elements.md
│       ├── Test-Rules.md
│       ├── Test-Patterns.md
│       └── Robot-Conventions.md
│
├── /results
│   ├── log.html
│   ├── report.html
│   └── output.xml
│
├── requirements.txt
├── README.md
└── .gitignore
```

#### Propósito de Cada Diretório

| Diretório | Propósito | Conteúdo |
|-----------|-----------|----------|
| `/tests` | Casos de teste | Arquivos `.robot` com test cases |
| `/resources/keywords` | Lógica de negócio | Keywords customizadas de alto nível |
| `/resources/pages` | Locators | Page Objects com locators |
| `/resources/common` | Configurações | Variáveis e configs compartilhadas |
| `/docs` | Documentação | PRD, SDD, e documentos relacionados |
| `/results` | Relatórios | Logs e relatórios de execução |

---

### 📄 Estrutura de Arquivo de Teste

```robotframework
*** Settings ***
Documentation     [Descrição da suite]
Library           [Bibliotecas necessárias]
Resource          [Resources necessários]
Suite Setup       [Setup da suite]
Suite Teardown    [Teardown da suite]

*** Variables ***
${VAR1}           valor1
${VAR2}           valor2

*** Test Cases ***
Test Case 1
    [Documentation]    [Descrição]
    [Tags]    [tags]
    [Steps do teste]

Test Case 2
    [Documentation]    [Descrição]
    [Tags]    [tags]
    [Steps do teste]

*** Keywords ***
# Keywords específicas deste arquivo (opcional)
# Preferencialmente usar keywords de /resources/keywords
```

---

### 📄 Estrutura de Arquivo de Keywords

```robotframework
*** Settings ***
Documentation     [Descrição das keywords]
Library           [Bibliotecas se necessário]
Resource          [Pages e outros resources]

*** Keywords ***
Keyword de Alto Nível 1
    [Documentation]    [Descrição]
    [Arguments]    [args]
    [Implementação]

Keyword de Alto Nível 2
    [Documentation]    [Descrição]
    [Arguments]    [args]
    [Implementação]
```

---

### 📄 Estrutura de Arquivo de Page Object

```robotframework
*** Settings ***
Documentation     Page Object para [nome da tela]
...               Centraliza locators e ações básicas

*** Keywords ***
# Getters de Locators
Obter Localizador Elemento 1
    [Documentation]    Retorna localizador do elemento 1
    [Return]    id=elemento1

Obter Localizador Elemento 2
    [Documentation]    Retorna localizador do elemento 2
    [Return]    xpath=//div[@id='elemento2']

# Ações Básicas (opcional)
Clicar em Elemento 1
    ${localizador}=    Obter Localizador Elemento 1
    Click Element    ${localizador}
```

---

## 3. Boas Práticas

### ✅ Nomenclatura

1. **Test Cases**: Nomes descritivos em português
   ```robotframework
   ✅ Criar Alarme no Período AM
   ❌ test1
   ❌ CreateAlarm
   ```

2. **Keywords**: Verbos no infinitivo em português
   ```robotframework
   ✅ Clicar em Botão Adicionar
   ✅ Validar Mensagem de Erro
   ❌ ClicaBotao
   ❌ clicking_button
   ```

3. **Variáveis**: MAIÚSCULAS com underscores
   ```robotframework
   ✅ ${TIMEOUT_PADRAO}
   ✅ ${HORA_AM}
   ❌ ${timeoutPadrao}
   ❌ ${hora-am}
   ```

4. **Arquivos**: snake_case com prefixo
   ```
   ✅ test_alarm.robot
   ✅ alarm_keywords.robot
   ✅ alarm_page.robot
   ❌ TestAlarm.robot
   ❌ Alarm.robot
   ```

---

### ✅ Organização

1. **Separação de Responsabilidades**
   - Testes: apenas test cases (BDD)
   - Keywords: lógica de negócio
   - Pages: locators e ações básicas

2. **Um Arquivo por Funcionalidade**
   ```
   test_alarm.robot      # Apenas testes de alarme
   test_timer.robot      # Apenas testes de timer
   ```

3. **Imports no Topo**
   ```robotframework
   *** Settings ***
   # Primeiro: Libraries
   Library    AppiumLibrary
   Library    Collections
   
   # Depois: Resources
   Resource    ../resources/pages/alarm_page.robot
   Resource    ../resources/keywords/alarm_keywords.robot
   ```

---

### ✅ Documentação

1. **Documentation Obrigatória**
   ```robotframework
   *** Test Cases ***
   Criar Alarme
       [Documentation]    Valida criação de alarme
       ...                Verifica persistência do alarme
   ```

2. **Tags Descritivas**
   ```robotframework
   [Tags]    alarme    am    funcional    p0    smoke
   ```

3. **Comentários em Lógica Complexa**
   ```robotframework
   # Aguarda 8s devido a limitação de hardware
   Sleep    8s
   ```

---

### ✅ Waits e Timeouts

1. **Sempre Usar Wait Antes de Interagir**
   ```robotframework
   ✅ Wait Until Element Is Visible    ${LOCATOR}    timeout=20s
      Click Element    ${LOCATOR}
   
   ❌ Click Element    ${LOCATOR}
   ```

2. **Timeouts Adequados**
   ```robotframework
   ${TIMEOUT_ELEMENTO_SIMPLES}    10s
   ${TIMEOUT_NAVEGACAO}           20s
   ${TIMEOUT_ACAO_COMPLEXA}       30s
   ```

3. **Evitar Sleep Desnecessários**
   ```robotframework
   ❌ Click Element    ${BOTAO}
      Sleep    5s    # Use wait ao invés
   
   ✅ Click Element    ${BOTAO}
      Wait Until Element Is Visible    ${PROXIMO_ELEMENTO}    timeout=10s
   ```

---

### ✅ Validações

1. **Mensagens de Erro Descritivas**
   ```robotframework
   Should Be True    ${encontrado}
   ...    msg=Alarme ${hora}:${minuto} ${periodo} não encontrado
   ```

2. **Validações Apropriadas**
   ```robotframework
   Element Should Be Visible    ${LOCATOR}
   Element Text Should Be    ${LOCATOR}    Texto Esperado
   Should Be Equal    ${valor}    esperado
   ```

---

## 4. Configuração de Ambiente

### 🔧 Pré-requisitos

#### Ferramentas Necessárias

1. **Python 3.8+**
   ```bash
   python --version
   # Deve mostrar: Python 3.8.x ou superior
   ```

2. **Robot Framework**
   ```bash
   pip install robotframework
   robot --version
   # Deve mostrar: Robot Framework 7.0 ou superior
   ```

3. **AppiumLibrary** (para automação mobile)
   ```bash
   pip install robotframework-appiumlibrary
   ```

4. **Appium Server** (para automação mobile)
   ```bash
   npm install -g appium
   appium driver install uiautomator2
   ```

5. **Android SDK** (para Android)
   ```bash
   adb version
   # Deve mostrar versão do ADB
   ```

---

### 📦 requirements.txt

**Versões Estáveis Testadas (Recomendado):**
```txt
robotframework==7.0.1
robotframework-appiumlibrary==2.0.0
Appium-Python-Client==3.1.1
selenium==4.18.1
```

**Versões Mais Recentes (Alternativa):**
```txt
robotframework>=7.4.1
robotframework-appiumlibrary>=3.2.1
Appium-Python-Client>=5.2.5
selenium>=4.18.1
```

**⚠️ IMPORTANTE:** 
- Use um conjunto completo de versões compatíveis
- Não misture robotframework-appiumlibrary 2.0.0 com Appium-Python-Client 5.x+
- Não misture robotframework-appiumlibrary 3.x+ com Appium-Python-Client 3.x

**Instalação**:
```bash
# Versões estáveis
pip install -r requirements.txt

# OU versões mais recentes
pip install -r requirements-latest.txt
```

---

### 🔧 Configuração do Dispositivo Android

#### Formato de 12 Horas (CRÍTICO para testes de alarme)

```bash
# Verificar formato atual
adb shell settings get system time_12_24

# Se retornar "24", mudar para formato 12h:
adb shell settings put system time_12_24 12
```

**Alternativa Manual**: 
Settings > System > Date & time > Use 24-hour format = OFF

#### Verificar Dispositivo Conectado

```bash
adb devices
# Saída esperada: emulator-5554   device
```

#### Verificar Aplicativo Instalado

```bash
adb shell pm list packages | grep deskclock
# Saída esperada: package:com.google.android.deskclock
```

---

### 🚀 Iniciar Servidor Appium

```bash
# Em um terminal separado
appium

# Verificar porta 4723
# Saída esperada: "Appium REST http interface listener started on 0.0.0.0:4723"
```

---

## 5. Execução de Testes

### 🎯 Comandos Básicos

#### Executar Todos os Testes

```bash
robot --pythonpath . tests/
```

#### Executar Arquivo Específico

```bash
robot --pythonpath . tests/test_alarm.robot
```

#### Executar Test Case Específico

```bash
robot --pythonpath . --test "Criar Alarme no Período AM" tests/test_alarm.robot
```

---

### 🏷️ Execução por Tags

```bash
# Executar testes com tag específica
robot --pythonpath . --include alarme tests/

# Executar testes com múltiplas tags
robot --pythonpath . --include alarmANDp0 tests/

# Executar testes excluindo tag
robot --pythonpath . --exclude wip tests/

# Combinação complexa
robot --pythonpath . --include p0ORsmoke --exclude wip tests/
```

---

### 📊 Opções de Report

```bash
# Com logs detalhados
robot --pythonpath . --loglevel DEBUG tests/

# Definir diretório de saída
robot --pythonpath . --outputdir results tests/

# Nome customizado para arquivos
robot --pythonpath . --output meu_output.xml --report meu_report.html tests/

# Desabilitar screenshot automático
robot --pythonpath . --listener 'AppiumLibrary.listener.AppiumListener:screenshot_on_failure=False' tests/
```

---

### ⚡ Execução Paralela

```bash
# Usando pabot (install: pip install robotframework-pabot)
pabot --processes 4 --pythonpath . tests/
```

---

### 🔄 Re-executar Falhas

```bash
# Primeira execução
robot --pythonpath . --outputdir results tests/

# Re-executar apenas testes que falharam
robot --pythonpath . --rerunfailed results/output.xml --outputdir results/rerun tests/

# Merge resultados
rebot --outputdir results --merge results/output.xml results/rerun/output.xml
```

---

## 6. Troubleshooting

### 🐛 Problemas Comuns

#### Problema: "No module named 'appium.webdriver.common.touch_action'"

**Causa:** Incompatibilidade de versões - você misturou versões de diferentes épocas

**Exemplos de combinações incompatíveis:**
- ❌ robotframework-appiumlibrary 2.0.0 + Appium-Python-Client 5.x
- ❌ robotframework-appiumlibrary 3.x + Appium-Python-Client 3.1.x
- ❌ robotframework-appiumlibrary 2.0.0 + Appium-Python-Client 4.x

**Solução:**
```bash
# Desinstalar tudo
pip uninstall -y robotframework robotframework-appiumlibrary Appium-Python-Client selenium

# OPÇÃO 1: Reinstalar versões estáveis (recomendado)
pip install -r requirements.txt

# OPÇÃO 2: Reinstalar versões mais recentes
pip install -r requirements-latest.txt
```

**Explicação**: 
- robotframework-appiumlibrary 2.0.0 requer Appium-Python-Client 3.1.x
- robotframework-appiumlibrary 3.2.1+ requer Appium-Python-Client 5.x+
- O Appium-Python-Client 4.x removeu o módulo `touch_action`
- Versões mais recentes da appiumlibrary foram atualizadas para não usar `touch_action`

**Consulte**: [QUICK-FIX.md](../../../QUICK-FIX.md) no raiz do projeto para solução detalhada.

---

#### Problema: "App de Relógio não abre / Teste quebra no Suite Setup"

**Sintomas**:
- Appium conecta com sucesso mas app não abre
- Teste fica na tela inicial (launcher) do Android
- Erro: `Element locator 'xpath=//android.widget.ImageButton[@content-desc="Add alarm"]' did not match any elements after 20 seconds`
- Log XML mostra `package="com.google.android.apps.nexuslauncher"` em vez de `com.google.android.deskclock`
- Suite Setup falha ao procurar botão "Add alarm"

**Causa Raiz**: 
Capability `appium:noReset=true` faz o Appium **não reiniciar** o app. Se o dispositivo estava no launcher antes, o Appium volta para o launcher em vez de abrir o app de Relógio.

**Solução obrigatória nas capabilities**:
```robotframework
Open Application    http://localhost:4723
...    appium:noReset=false          # ✅ CORRETO: Reinicia app
...    appium:fullReset=false        # ✅ CORRETO: Não desinstala
...    appium:dontStopAppOnReset=false  # ✅ CORRETO: Garante reinício
```

**Validação robusta necessária** (implementar após Open Application):
```robotframework
Abrir Aplicativo de Relógio
    Open Application    http://localhost:4723  ...
    Sleep    5s  # Aguardar inicialização
    
    # Validação com 3 níveis de fallback
    ${localizador_fab}=    Obter Localizador Botão Adicionar Alarme
    ${app_opened}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${localizador_fab}    timeout=10s
    
    IF    not ${app_opened}
        # Fallback 1: Tentar clicar na aba Alarm
        ${aba_alarm}=    Set Variable    xpath=//android.widget.TextView[@text="Alarm"]
        Run Keyword And Ignore Error    Click Element    ${aba_alarm}
        Sleep    2s
        
        # Fallback 2: Forçar abertura via ADB
        Run Keyword And Ignore Error
        ...    Run Process    adb    shell    am    start    -n
        ...    com.google.android.deskclock/com.android.deskclock.DeskClock
        Sleep    3s
        
        # Validar que agora está aberto
        Wait Until Element Is Visible    ${localizador_fab}    timeout=10s
    END
```

**Diagnóstico manual** (caso problema persista):
```bash
# 1. Verificar se app está instalado
adb shell pm list packages | grep clock
# Deve retornar: package:com.google.android.deskclock

# 2. Verificar package e activity corretos
adb shell dumpsys package com.google.android.deskclock | grep -A 1 'android.intent.action.MAIN'

# 3. Tentar abrir manualmente
adb shell am start -n com.google.android.deskclock/com.android.deskclock.DeskClock

# 4. Verificar qual app está com foco
adb shell dumpsys window | grep mCurrentFocus
# Deve mostrar: com.google.android.deskclock/com.android.deskclock.DeskClock

# 5. Verificar servidor Appium rodando
netstat -ano | findstr :4723
# Ou no Linux/Mac: lsof -i :4723

# 6. Verificar driver instalado
appium driver list
# Deve mostrar: uiautomator2 [installed]
```

**Bibliotecas necessárias**:
```robotframework
Library          Process    # Para executar comandos ADB
Library          OperatingSystem
```

**Impacto**: CRÍTICO - Impede todos os testes de executarem

**Referência**: SDD.md - Seção 8 (Configuração de Capabilities)

---

#### Problema: "No keyword with name 'Open Application' found"

**Causa**: Biblioteca AppiumLibrary não foi carregada devido ao erro acima

**Solução**: Corrigir a incompatibilidade de versões conforme descrito no problema anterior

---

#### Problema: "Element not found"

**Causa**: Formato 24h ativo ou locator incorreto

**Solução**:
```bash
# Verificar e corrigir formato de hora
adb shell settings get system time_12_24
adb shell settings put system time_12_24 12

# Reiniciar teste
```

---

#### Problema: "No keyword with name"

**Causa**: Pythonpath não configurado ou biblioteca não importada

**Solução**:
```bash
# Sempre usar --pythonpath .
robot --pythonpath . tests/test_alarm.robot
```

---

#### Problema: "Session not created"

**Causa**: Appium não está rodando

**Solução**:
```bash
# Em terminal separado, iniciar Appium
appium

# Verificar se está na porta 4723
```

---

#### Problema: "Device not found"

**Causa**: ADB desconectado

**Solução**:
```bash
adb kill-server
adb start-server
adb devices
# Verificar se dispositivo aparece
```

---

#### Problema: Testes muito lentos

**Causa**: Timeouts muito altos

**Solução**:
- Após primeira execução bem-sucedida, reduzir timeouts
- Otimizar waits
- Remover sleeps desnecessários

---

### 📋 Checklist de Troubleshooting

**Antes de Rodar os Testes:**
- [ ] Python 3.8+ instalado?
- [ ] Robot Framework instalado?
- [ ] AppiumLibrary instalada? (versão 2.0.0)
- [ ] Appium-Python-Client versão 3.1.x? (NÃO 4.x ou 5.x)
- [ ] Appium Server rodando na porta 4723?
- [ ] Driver UiAutomator2 instalado? (`appium driver list`)
- [ ] Dispositivo Android conectado? (`adb devices`)
- [ ] Dispositivo em formato 12h? (`adb shell settings get system time_12_24` deve retornar `12`)
- [ ] Aplicativo de Relógio instalado no dispositivo?

**Configuração de Capabilities:**
- [ ] `appium:noReset=false` (NÃO use `true`)
- [ ] `appium:fullReset=false` configurado?
- [ ] `appium:dontStopAppOnReset=false` configurado?
- [ ] Package correto: `com.google.android.deskclock`?
- [ ] Activity correta: `com.android.deskclock.DeskClock`?

**Ao Executar:**
- [ ] Comando usa `--pythonpath .`?
- [ ] App de Relógio abre corretamente?
- [ ] Tela de alarmes está visível com botão "Add alarm"?
- [ ] Logs mostram qual erro específico (se houver)?

**Pós-Execução:**
- [ ] Screenshots capturados em caso de falha?
- [ ] Log detalhado analisado (log.html)?
- [ ] Page source capturado para diagnóstico?

---

### 📊 Taxa de Sucesso Esperada

Com todos os pré-requisitos atendidos:

- **Sem preparação**: 60-70%
- **Com checklist básico**: 75-85%
- **Com checklist completo**: 95-100%

**Ponto Crítico**: Configuração do formato de 12 horas no dispositivo

---

## 📚 Referências Oficiais

- [Robot Framework User Guide](https://robotframework.org/robotframework/)
- [Robot Framework Standard Libraries](https://robotframework.org/robotframework/#standard-libraries)
- [Built-in Library](https://robotframework.org/robotframework/latest/libraries/BuiltIn.html)
- [AppiumLibrary](https://serhatbolsu.github.io/robotframework-appiumlibrary/AppiumLibrary.html)
- [Appium Documentation](http://appium.io/docs/)

---

## 📚 Referências do Projeto

- [PRD.md](PRD.md): Requisitos do produto
- [SDD.md](SDD.md): Design técnico
- [Elements.md](Elements.md): Mapeamento de elementos
- [Test-Rules.md](Test-Rules.md): Regras de nomenclatura e estruturação
- [Test-Patterns.md](Test-Patterns.md): Padrões de implementação
