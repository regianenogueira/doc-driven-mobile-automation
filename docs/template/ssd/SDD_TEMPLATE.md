# Software Design Document (SDD) - [NOME DO PROJETO]

> **Template de Estrutura para Documentação de Design de Software**  
> Substitua os textos entre [colchetes] com informações do seu projeto

---

## 📋 Informações do Documento

- **Projeto**: [Nome do Projeto]
- **Versão**: 1.0
- **Data**: [Data de Criação]
- **Autor**: [Nome do QA/Dev]

---

## ⚠️ REGRA IMPORTANTE: Não Criar Arquivos de Documentação Durante Implementação

**Regra Obrigatória**: Ao implementar testes a partir desta documentação, o Copilot ou qualquer ferramenta de IA **NÃO deve criar arquivos Markdown (.md)** adicionais.

**Único Arquivo Permitido**: README.md na raiz do projeto

**Justificativa**: 
- A documentação completa já existe em docs/[nome-projeto]/
- Criar documentos adicionais gera duplicação de informação
- Dificulta manutenção (informações em múltiplos lugares)
- O README.md serve como ponto de entrada com instruções de uso

**O que deve ser criado**:
- ✅ Arquivos de teste (.robot / .py / .js / .spec)
- ✅ Arquivos de keywords (.robot)
- ✅ Arquivos de pages (.robot / .py / .js)
- ✅ README.md (instruções de execução)
- ✅ requirements.txt / package.json (dependências)
- ✅ Scripts de automação (.sh, .bat)

**O que NÃO deve ser criado**:
- ❌ Documentos de resumo (.md)
- ❌ Documentos de alterações (.md)
- ❌ Documentos de análise (.md)
- ❌ Qualquer outro arquivo Markdown além do README.md

---

## 1. Visão Geral Técnica

### Stack Tecnológico

**Framework de Teste**: [Robot Framework / Pytest / Jest / Mocha / Outro]
- **Versão**: [X.X.X]
- **Documentação**: [Link]

**Ferramenta de Automação**: [Appium / Selenium / Playwright / Cypress / Outro]
- **Versão**: [X.X.X]
- **Driver**: [UiAutomator2 / XCUITest / ChromeDriver / Outro]

**Plataforma Alvo**: [Android / iOS / Web / Desktop]
- **Versão Mínima**: [API Level / iOS version / Browser version]
- **Versão Testada**: [Versão específica onde foi validado]

**Linguagem de Programação**: [Python / JavaScript / Java / C# / Outro]
- **Versão**: [X.X.X]

### Bibliotecas e Dependências

**Principais**:
- [biblioteca-1]: [versão] - [propósito]
- [biblioteca-2]: [versão] - [propósito]
- [biblioteca-3]: [versão] - [propósito]

**Auxiliares**:
- [biblioteca-4]: [versão] - [propósito]
- [biblioteca-5]: [versão] - [propósito]

### Versões Testadas e Compatíveis

**⚠️ IMPORTANTE**: Use conjuntos completos de versões compatíveis

**Conjunto Recomendado** (testado e estável):
```
[framework]==X.X.X
[biblioteca-1]==X.X.X
[biblioteca-2]==X.X.X
```

**Incompatibilidades Conhecidas**:
- ❌ NÃO usar [biblioteca-A] versão X com [biblioteca-B] versão Y
- ❌ [Outra incompatibilidade conhecida]

---

## 2. Arquitetura do Projeto

### Estrutura de Diretórios

```
/[nome-projeto]
├── /tests                    # Casos de teste
│   ├── test_[funcionalidade1].robot
│   └── test_[funcionalidade2].robot
├── /resources                # Recursos compartilhados
│   ├── /keywords            # Keywords de negócio
│   │   ├── [nome]_keywords.robot
│   │   └── common_keywords.robot
│   ├── /pages               # Page Objects (locators)
│   │   ├── [nome]_page.robot
│   │   └── base_page.robot
│   └── /variables           # Variáveis globais (opcional)
│       └── config.robot
├── /docs                    # Documentação do projeto
│   └── /[nome-projeto]
│       ├── PRD.md
│       ├── SDD.md
│       ├── Elements.md
│       └── /test-knowledge
├── /results                 # Logs e relatórios de execução
│   ├── log.html
│   ├── output.xml
│   └── report.html
├── /scripts                 # Scripts de automação (opcional)
│   ├── setup.sh
│   └── run_tests.sh
├── README.md               # Instruções de setup e execução
└── requirements.txt        # Dependências Python (ou package.json)
```

### Propósito de Cada Camada

#### 1. Camada de Testes (`/tests`)
**Responsabilidade**: 
- Definir cenários de teste em formato BDD ou similar
- Usar apenas keywords de alto nível
- Manter testes legíveis por não-técnicos

**NÃO deve**:
- Acessar locators diretamente
- Conter lógica complexa
- Ter dependências entre testes

#### 2. Camada de Keywords (`/resources/keywords`)
**Responsabilidade**:
- Implementar lógica de negócio dos testes
- Combinar ações de Page Objects
- Fornecer abstração para cenários complexos

**Exemplo de Estrutura**:
```robotframework
*** Keywords ***
[Ação de Negócio]
    [Documentation]    [Descrição clara]
    ${locator}=    [Obter Locator da Page]
    [Ações usando locator]
    [Validações]
```

#### 3. Camada de Pages (`/resources/pages`)
**Responsabilidade**:
- Centralizar todos os locators
- Implementar ações básicas de UI
- Seguir padrão Page Object Model

**Exemplo de Estrutura**:
```robotframework
*** Keywords ***
Obter Localizador [Nome do Elemento]
    [Documentation]    Retorna localizador do [elemento]
    [Return]    [xpath/id/css]
```

### Fluxo de Dependências

```
Tests → Keywords → Pages
  ↓         ↓         ↓
 BDD    Negócio   Locators
```

**Regra de Ouro**: Cada camada só pode depender da camada abaixo dela.

---

## 3. Metodologia de Testes

### Abordagem: [BDD / TDD / Keyword-Driven / Outro]

**Formato de Escrita**: [Gherkin / Given-When-Then / Descritivo]

### Estrutura de Cenário BDD

```robotframework
*** Test Cases ***
[Nome Descritivo do Teste]
    [Documentation]    [Descrição detalhada do que é testado]
    [Tags]    [tag1]    [tag2]
    
    Dado [pré-condição]
    Quando [ação do usuário]
    E [ação adicional se necessário]
    Então [resultado esperado]
    E [validação adicional]
```

### Convenções de Escrita

- **Test Cases**: [Português / Inglês], formato [Sentença / CamelCase / snake_case]
- **Keywords**: [Português / Inglês], iniciar com [Verbo no infinitivo / Substantivo]
- **Variáveis**: [MAIÚSCULAS / camelCase / snake_case]

---

## 4. Documentação de Locators

### Estratégia de Mapeamento

**Ordem de Preferência para Locators**:
1. **[Accessibility ID / Content-desc]** - Independente de idioma e versão
2. **[Resource ID / ID]** - Estável e único
3. **[XPath com atributos únicos]** - Quando os acima não estão disponíveis
4. **[XPath hierárquico]** - Último recurso (frágil)

### Padrão de Nomenclatura

**Page Objects**:
```
Obter Localizador [Nome Descritivo do Elemento]
```

**Exemplo**:
```robotframework
Obter Localizador Botão Login
Obter Localizador Campo Email
Obter Localizador Mensagem Erro
```

### Estratégias de Resiliência

**Para Elementos Dinâmicos**:
- Usar atributos estáveis
- Implementar fallback de locators
- Documentar variações conhecidas

**Exemplo de Fallback**:
```robotframework
Obter Localizador [Elemento] Primário
    [Return]    [locator preferencial]

Obter Localizador [Elemento] Secundário
    [Return]    [locator alternativo]
```

---

## 5. Documentação de Keywords

### Tipos de Keywords

#### Keywords de Page Object
**Propósito**: Retornar locators ou executar ações básicas de UI

**Padrão**:
```robotframework
Obter Localizador [Elemento]
    [Return]    [locator]

Clicar em [Elemento]
    ${locator}=    Obter Localizador [Elemento]
    Click Element    ${locator}
```

#### Keywords de Negócio
**Propósito**: Implementar lógica de casos de uso

**Padrão**:
```robotframework
[Ação de Negócio]
    [Passo 1 usando Page Objects]
    [Passo 2 usando Page Objects]
    [Validação]
```

#### Keywords de Validação
**Propósito**: Verificar estados e resultados

**Padrão**:
```robotframework
Validar [Condição]
    [Obter elemento/valor]
    Should [condição]
```

### Documentação Obrigatória

Toda keyword customizada deve ter:
```robotframework
[Nome da Keyword]
    [Documentation]    [Descrição clara do que faz]
    [Arguments]    [Argumentos se houver]
    
    [Implementação]
    
    [Return]    [Valor de retorno se houver]
```

---

## 6. Documentação de Steps (Test Cases)

### Estrutura de Test Case

```robotframework
*** Test Cases ***
[Nome Descritivo]
    [Documentation]    [O que este teste valida]
    ...                [Detalhes adicionais]
    [Tags]    [categoria]    [prioridade]
    
    [Setup]    [Preparação se necessário]
    
    [Passo 1]
    [Passo 2]
    [Passo 3]
    [Validação]
    
    [Teardown]    [Limpeza se necessário]
```

### Tags Recomendadas

- **Prioridade**: `P0`, `P1`, `P2`
- **Categoria**: `smoke`, `regression`, `sanity`
- **Funcionalidade**: `[nome-funcionalidade]`
- **Plataforma**: `android`, `ios`, `web`

---

## 7. Padrões de Implementação

### Pattern: Page Object Model

**Objetivo**: Centralizar locators e reduzir manutenção

**Implementação**: Ver exemplo completo em [test-knowledge/Test-Patterns.md](../test-knowledge/TEST_PATTERNS_TEMPLATE.md)

### Pattern: Wait Strategies

**Objetivo**: Garantir sincronização com aplicação

**Padrão Recomendado**:
```robotframework
Wait Until Element Is Visible    ${locator}    timeout=[X]s
```

**Timeouts Padrão**:
- Elementos comuns: [10]s
- Elementos após ação: [20]s
- Carregamento de tela: [30]s

### Pattern: Error Handling

**Objetivo**: Testes resilientes e informativos

**Implementação**:
```robotframework
Run Keyword And Return Status
Run Keyword And Ignore Error
Try-Except (Python keywords)
```

---

## 8. Configuração de Capabilities

### [Appium / Selenium / Outro] Configuration

**Capabilities Principais**:
```python
{
    "platformName": "[Android/iOS/Web]",
    "platformVersion": "[version]",
    "[chave]": "[valor]",
    "[chave]": "[valor]"
}
```

**Capabilities Opcionais**:
```python
{
    "[performance]": "[valor]",
    "[logging]": "[valor]",
    "[timeout]": "[valor]"
}
```

### Variáveis de Ambiente

```robotframework
*** Variables ***
${APPIUM_SERVER}     [URL do servidor]
${PLATFORM}          [Android/iOS]
${DEVICE_NAME}       [Nome do dispositivo]
${APP_PACKAGE}       [Package name]
${APP_ACTIVITY}      [Activity name]
```

---

## 9. Estratégias de Resiliência

### Tratamento de Elementos Não Encontrados

**Estratégia 1: Fallback de Locators**
```robotframework
Aguardar e Clicar [Elemento]
    ${status}=    Run Keyword And Return Status
    ...    Click Element    [locator primário]
    Run Keyword If    not ${status}
    ...    Click Element    [locator secundário]
```

**Estratégia 2: Retry Pattern**
```robotframework
Wait Until Keyword Succeeds
    [tentativas]x    [intervalo]s    [Keyword]
```

### Tratamento de Sincronização

**Aguardar Estado do App**:
```robotframework
Wait Until Element Is Visible
Wait Until Page Contains
Wait Until Page Does Not Contain
```

**Custom Wait**:
```robotframework
Aguardar [Condição Específica]
    FOR    ${i}    IN RANGE    [tentativas]
        ${status}=    [Verificar condição]
        Return From Keyword If    ${status}
        Sleep    [intervalo]s
    END
    Fail    [Mensagem de timeout]
```

### Captura de Evidências

**Em Falhas**:
```robotframework
*** Settings ***
Test Teardown    Run Keyword If Test Failed    Capturar Evidências

*** Keywords ***
Capturar Evidências
    Capture Page Screenshot
    [Log informações adicionais]
```

---

## 10. Execução e Relatórios

### Comandos de Execução

**Execução Completa**:
```bash
[comando] -d results tests/
```

**Execução Filtrada**:
```bash
[comando] --include [tag] tests/
[comando] --exclude [tag] tests/
```

**Execução Paralela** (se suportado):
```bash
[comando para execução paralela]
```

### Configuração de Relatórios

**Personalização**:
```bash
[opções de relatório]
```

**Arquivos Gerados**:
- `log.html` - Log detalhado
- `report.html` - Relatório executivo
- `output.xml` - Dados em XML

---

## 11. Manutenibilidade

### Princípios

1. **DRY** (Don't Repeat Yourself) - Reutilizar keywords
2. **Single Responsibility** - Cada keyword faz uma coisa
3. **Readable** - Código autoexplicativo
4. **Documented** - Documentação inline clara

### Code Review Checklist

- [ ] Locators estão em Page Objects
- [ ] Keywords têm documentação
- [ ] Testes são independentes
- [ ] Não há hardcoded waits (Sleep)
- [ ] Validações são claras
- [ ] Nomes são descritivos

---

## 12. Troubleshooting

### Problemas Comuns

| Problema | Causa | Solução |
|----------|-------|---------|
| [Problema 1] | [Causa] | [Solução] |
| [Problema 2] | [Causa] | [Solução] |
| [Problema 3] | [Causa] | [Solução] |

### Debug

**Habilitar logs detalhados**:
```bash
[comando com verbose]
```

**Verificar configuração**:
```bash
[comandos de verificação]
```

---

## Glossário

| Termo | Definição |
|-------|-----------|
| Page Object | [Definição] |
| Keyword | [Definição] |
| [Termo 3] | [Definição] |

---

## Referências

- [Documentação do Framework](URL)
- [Documentação da Ferramenta](URL)
- [Best Practices](URL)
- PRD: [link para PRD.md]
- Elements: [link para Elements.md]
- Test Knowledge: [link para pasta]

---

## Histórico de Revisões

| Versão | Data | Autor | Alterações |
|--------|------|-------|------------|
| 1.0 | [Data] | [Nome] | Criação inicial |
