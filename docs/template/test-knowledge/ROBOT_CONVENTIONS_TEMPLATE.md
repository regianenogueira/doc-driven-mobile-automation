# Robot Framework Conventions - [NOME DO PROJETO]

> **Template de Convenções e Boas Práticas do Robot Framework**  
> Adapte este documento para convenções específicas do seu projeto

---

## 📋 Tópicos Cobertos

Este documento cobre:

1. **Sintaxe do Robot Framework** - Regras de escrita
2. **Estrutura de Projeto** - Organização de arquivos
3. **Boas Práticas** - Convenções recomendadas
4. **Configuração de Ambiente** - Setup e pré-requisitos
5. **Execução de Testes** - Comandos e opções
6. **Troubleshooting** - Problemas comuns

---

## 1. Sintaxe do Robot Framework

### 📝 Seções do Arquivo .robot

Todo arquivo Robot Framework pode conter 4 seções:

```robotframework
*** Settings ***
# Imports, configurações, setup/teardown

*** Variables ***
# Variáveis globais do arquivo

*** Test Cases ***
# Cenários de teste (obrigatório em arquivos de teste)

*** Keywords ***
# Keywords customizadas (obrigatório em arquivos de resources)
```

**Regras**:
- ✅ Nomes de seções são case-insensitive
- ✅ Seções são opcionais (exceto Test Cases em testes)
- ✅ Usar `***` ou `*` antes e depois do nome
- ✅ Respeitar ordem: Settings → Variables → Test Cases → Keywords

---

### 🔤 Separadores e Indentação

#### Separadores

Robot Framework usa **espaços** como separadores (mínimo 2):

```robotframework
# ✅ CORRETO - 4 espaços
Click Element    ${LOCATOR}    timeout=10s

# ✅ CORRETO - Tabs
Click Element	${LOCATOR}	timeout=10s

# ❌ ERRADO - 1 espaço
Click Element ${LOCATOR} timeout=10s
```

**Recomendação**: [4 espaços / 2 espaços / tabs]

#### Indentação

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

**Recomendação**: [4 espaços / 2 espaços] por nível

---

### 📦 Settings

#### Settings em Arquivos de Teste

```robotframework
*** Settings ***
Documentation     [Descrição dos testes]
...               [Linha adicional de documentação]

Library           [Biblioteca1]
Library           [Biblioteca2]

Resource          [caminho/para/resource.robot]

Suite Setup       [Keyword executada antes de todos os testes]
Suite Teardown    [Keyword executada após todos os testes]
Test Setup        [Keyword executada antes de cada teste]
Test Teardown     [Keyword executada após cada teste]

Default Tags      [tag_padrão]
```

#### Settings em Arquivos de Resource

```robotframework
*** Settings ***
Documentation     [Descrição das keywords fornecidas]

Library           [Biblioteca necessária]
Resource          [outro_resource.robot]
```

---

### 🔢 Variáveis

#### Tipos de Variáveis

```robotframework
*** Variables ***
# Escalares
${VARIAVEL_TEXTO}     Valor texto
${VARIAVEL_NUMERO}    123

# Listas
@{LISTA}              item1    item2    item3

# Dicionários
&{DICT}               key1=value1    key2=value2
```

#### Convenção de Nomenclatura

**Variáveis Globais**:
- [TODAS_MAIUSCULAS / camelCase / outro]
- Exemplo: `${TIMEOUT_PADRAO}` ou `${timeoutPadrao}`

**Variáveis Locais**:
- [minusculas_com_underscore / camelCase / outro]
- Exemplo: `${localizador}` ou `${locator_element}`

---

### 🏷️ Test Cases

```robotframework
*** Test Cases ***
[Nome Descritivo do Teste]
    [Documentation]    [Descrição detalhada]
    [Tags]    [tag1]    [tag2]
    [Setup]    [Keyword de preparação]
    
    [Passo 1]
    [Passo 2]
    [Passo 3]
    
    [Teardown]    [Keyword de limpeza]
```

**Convenção de Nomenclatura**:
- Idioma: [Português / Inglês]
- Formato: [Sentença / CamelCase / snake_case]
- Exemplo: `Criar Usuário Com Sucesso` ou `Create User Successfully`

---

### 🔑 Keywords

```robotframework
*** Keywords ***
[Nome da Keyword]
    [Documentation]    [Descrição clara]
    [Arguments]    ${arg1}    ${arg2}
    
    [Implementação linha 1]
    [Implementação linha 2]
    
    [Return]    ${resultado}
```

**Convenção de Nomenclatura**:
- Iniciar com: [Verbo no infinitivo / Substantivo]
- Idioma: [Português / Inglês]
- Exemplo: `Clicar em Botão Login` ou `Click Login Button`

---

## 2. Estrutura de Projeto

### 📁 Organização de Arquivos

```
/[projeto]
├── /tests
│   └── test_*.robot          # Arquivos de teste
├── /resources
│   ├── /keywords
│   │   └── *_keywords.robot  # Keywords de negócio
│   └── /pages
│       └── *_page.robot      # Page Objects
├── /docs                      # Documentação
├── /results                   # Relatórios
├── requirements.txt           # Dependências
└── README.md                 # Instruções
```

### 📄 Estrutura de Arquivo de Teste

```robotframework
*** Settings ***
Documentation     [Descrição da suite]
Resource          ../resources/keywords/[nome]_keywords.robot
Suite Setup       [Setup se necessário]
Suite Teardown    [Teardown se necessário]

*** Variables ***
${VAR_ESPECIFICA}    [valor]

*** Test Cases ***
Teste 1
    [Passos]

Teste 2
    [Passos]
```

### 📄 Estrutura de Arquivo de Keywords

```robotframework
*** Settings ***
Documentation     [Descrição das keywords]
Resource          ../pages/[nome]_page.robot
Library           [Biblioteca]

*** Keywords ***
Keyword 1
    [Implementação]

Keyword 2
    [Implementação]
```

### 📄 Estrutura de Arquivo de Page

```robotframework
*** Settings ***
Documentation     Page Object para [Nome da Tela]
Library           [Biblioteca de automação]

*** Keywords ***
Obter Localizador [Elemento 1]
    [Return]    [locator]

Obter Localizador [Elemento 2]
    [Return]    [locator]

Clicar em [Elemento]
    ${locator}=    Obter Localizador [Elemento]
    Click Element    ${locator}
```

---

## 3. Boas Práticas

### ✅ Fazer

1. **Usar Page Objects**
   ```robotframework
   # ✅ BOM
   ${locator}=    Obter Localizador Botão Login
   Click Element    ${locator}
   
   # ❌ RUIM
   Click Element    xpath=//button[@id='login']
   ```

2. **Aguardar Elementos**
   ```robotframework
   # ✅ BOM
   Wait Until Element Is Visible    ${locator}    20s
   Click Element    ${locator}
   
   # ❌ RUIM
   Sleep    3s
   Click Element    ${locator}
   ```

3. **Documentar Keywords**
   ```robotframework
   # ✅ BOM
   Realizar Login
       [Documentation]    Faz login com usuário padrão
       [Passos]
   
   # ❌ RUIM
   Realizar Login
       [Sem documentação]
   ```

4. **Usar Variáveis**
   ```robotframework
   # ✅ BOM
   ${TIMEOUT}=    20s
   Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
   
   # ❌ RUIM
   Wait Until Element Is Visible    ${locator}    20s
   ```

### ❌ Evitar

1. **Sleep Fixo**
   ```robotframework
   # ❌ EVITAR
   Sleep    5s
   
   # ✅ PREFERIR
   Wait Until Element Is Visible    ${locator}    timeout=20s
   ```

2. **Locators Hardcoded**
   ```robotframework
   # ❌ EVITAR
   Click Element    xpath=//button[1]
   
   # ✅ PREFERIR
   ${locator}=    Obter Localizador Botão
   Click Element    ${locator}
   ```

3. **Testes Dependentes**
   ```robotframework
   # ❌ EVITAR - Teste 2 depende do Teste 1
   Teste 1
       Criar Usuario
   
   Teste 2
       [Assume que usuário já existe]
   
   # ✅ PREFERIR - Testes independentes
   Teste 1
       Criar Usuario
       [Teardown]    Deletar Usuario
   
   Teste 2
       [Setup]    Criar Usuario
       [Testa funcionalidade]
       [Teardown]    Deletar Usuario
   ```

---

## 4. Configuração de Ambiente

### Pré-requisitos

- **Python**: [versão mínima]
- **Robot Framework**: [versão]
- **[Ferramenta de Automação]**: [versão]
- **[Outras dependências]**

### Instalação

```bash
# [Comandos de instalação]
pip install -r requirements.txt

# ou
[outros comandos]
```

### Configuração

1. [Passo 1 de configuração]
2. [Passo 2 de configuração]
3. [Passo 3 de configuração]

---

## 5. Execução de Testes

### Comandos Básicos

**Executar todos os testes**:
```bash
robot -d results tests/
```

**Executar arquivo específico**:
```bash
robot -d results tests/test_[nome].robot
```

**Executar com tags**:
```bash
# Incluir tag
robot --include [tag] -d results tests/

# Excluir tag
robot --exclude [tag] -d results tests/

# Combinação
robot --include P0 --exclude wip -d results tests/
```

### Opções Úteis

```bash
# Verbose (mais detalhes)
robot -d results --loglevel DEBUG tests/

# Apenas logs de erro
robot -d results --loglevel ERROR tests/

# Reexecutar falhas
robot --rerunfailed output.xml -d results tests/

# Executar em paralelo (com pabot)
pabot --processes 4 -d results tests/
```

### Variáveis em Linha de Comando

```bash
robot -d results -v BROWSER:chrome -v ENV:staging tests/
```

---

## 6. Troubleshooting

### Problema: [Problema Comum 1]

**Sintoma**: [Descrição]

**Causa**: [Causa provável]

**Solução**:
```bash
[Solução ou código]
```

---

### Problema: [Problema Comum 2]

**Sintoma**: [Descrição]

**Causa**: [Causa provável]

**Solução**:
```robotframework
# [Solução]
```

---

### Problema: [Problema Comum 3]

**Sintoma**: [Descrição]

**Causa**: [Causa provável]

**Solução**:
[Passos para resolver]

---

## 7. Recursos Adicionais

### Documentação Oficial
- [Robot Framework User Guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
- [Biblioteca [Nome]](URL)

### Ferramentas Úteis
- **[Ferramenta 1]**: [Descrição]
- **[Ferramenta 2]**: [Descrição]

### Comunidade
- [Fórum/Slack/Discord]
- [Stack Overflow tag]

---

## Referências

- PRD: [link]
- SDD: [link]
- Test-Patterns: [link]
- Test-Rules: [link]
