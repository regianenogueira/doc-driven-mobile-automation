# Test Rules - [NOME DO PROJETO]

> **Template de Regras e Padrões de Testes**  
> Define regras obrigatórias para o projeto

---

## 📋 Seções

1. **Regras de Nomenclatura** - Como nomear testes, keywords e variáveis
2. **Regras de Estruturação** - Como organizar arquivos e código
3. **Regras de Validação** - Como implementar asserções
4. **Regras de Documentação** - O que documentar
5. **Regras de Manutenibilidade** - Boas práticas obrigatórias
6. **Regras de Criação de Arquivos** - Restrições

---

## ⚠️ REGRA CRÍTICA: Restrição de Criação de Arquivos

### RN-ARQ-001: Proibição de Criar Arquivos .md Durante Implementação

**Regra**: Ferramentas de IA **NÃO devem criar arquivos Markdown (.md)** ao implementar testes.

**Exceção**: README.md na raiz do projeto.

**Arquivos Permitidos**:
- ✅ README.md (apenas na raiz)
- ✅ Arquivos .robot / .py / .js (código de teste)
- ✅ requirements.txt / package.json
- ✅ Scripts (.sh, .bat, .py)
- ✅ Configurações (.json, .yaml, .ini)

**Arquivos Proibidos**:
- ❌ CHANGELOG.md
- ❌ SUMMARY.md
- ❌ ANALYSIS.md
- ❌ Qualquer .md além de README.md

**Justificativa**: Documentação completa já existe em docs/

**Violação**: Criar .md adicionais é violação desta regra

---

## 1. Regras de Nomenclatura

### 🔖 Test Cases

#### RN-NOM-001: Nome Descritivo em [Português/Inglês]

**Regra**: Test cases devem ter nomes claros e descritivos

**Formato**: `[Ação] [Objeto] [Condição]`

**Exemplos Válidos**:
```robotframework
✅ [Criar Usuário Com Sucesso]
✅ [Validar Erro em Campo Vazio]
✅ [Editar Perfil Com Dados Válidos]
```

**Exemplos Inválidos**:
```robotframework
❌ Test 1
❌ CreateUser
❌ teste_001
```

**Justificativa**: [Facilita compreensão]

---

#### RN-NOM-002: Keywords com [Verbo no Infinitivo]

**Regra**: Keywords devem iniciar com verbo de ação

**Formato**: `[Verbo] [Complemento]`

**Exemplos Válidos**:
```robotframework
✅ Clicar em Botão Login
✅ Inserir Texto no Campo Email
✅ Validar Mensagem de Sucesso
✅ Obter Localizador do Elemento
```

**Exemplos Inválidos**:
```robotframework
❌ Botão Login
❌ loginButton
❌ MSG_ERRO
```

---

#### RN-NOM-003: Variáveis em [MAIÚSCULAS/camelCase]

**Regra**: Variáveis globais em [MAIÚSCULAS], locais em [minúsculas]

**Exemplos Válidos**:
```robotframework
✅ ${TIMEOUT_PADRAO}
✅ ${localizador}
✅ @{LISTA_USUARIOS}
✅ &{CONFIG_AMBIENTE}
```

**Exemplos Inválidos**:
```robotframework
❌ ${TimeoutPadrao}  (global deveria ser maiúscula)
❌ ${LOCALIZADOR}    (local deveria ser minúscula)
```

---

### 📁 Arquivos

#### RN-NOM-004: Nomenclatura de Arquivos

**Regra**: Seguir padrão consistente

**Padrão**:
- Testes: `test_[nome].robot`
- Keywords: `[nome]_keywords.robot`
- Pages: `[nome]_page.robot`

**Exemplos Válidos**:
```
✅ test_login.robot
✅ login_keywords.robot
✅ login_page.robot
```

**Exemplos Inválidos**:
```
❌ LoginTest.robot
❌ keywords_login.robot
❌ Page_Login.robot
```

---

## 2. Regras de Estruturação

### 📦 Organização de Arquivos

#### RN-EST-001: Estrutura de Diretórios Obrigatória

**Regra**: Seguir estrutura padrão definida no SDD

**Estrutura Mínima**:
```
/projeto
├── /tests
├── /resources
│   ├── /keywords
│   └── /pages
└── /results
```

**Violação**: Criar estrutura diferente sem justificativa

---

#### RN-EST-002: Separação de Responsabilidades

**Regra**: 
- Tests: apenas cenários BDD
- Keywords: lógica de negócio
- Pages: locators e ações de UI

**Violação**: 
```robotframework
# ❌ ERRADO - Locator em teste
*** Test Cases ***
Login
    Click Element    xpath=//button[@id='login']

# ✅ CORRETO - Usar keyword
*** Test Cases ***
Login
    Clicar em Botão Login
```

---

### 🏗️ Estrutura de Código

#### RN-EST-003: [Regra de Indentação]

**Regra**: Usar [4 espaços / 2 espaços / tabs] consistentemente

**Obrigatório**: [Especificar padrão]

---

## 3. Regras de Validação

### ✅ Assertions

#### RN-VAL-001: Validações Explícitas

**Regra**: Toda validação deve ter mensagem clara

**Correto**:
```robotframework
✅ Should Be Equal    ${resultado}    ${esperado}
    ...    msg=Resultado deveria ser ${esperado}, obtido ${resultado}
```

**Incorreto**:
```robotframework
❌ Should Be Equal    ${resultado}    ${esperado}
```

---

#### RN-VAL-002: [Tipo de Validação Obrigatória]

**Regra**: [Especificar que tipo de validação é obrigatória]

**Exemplos**: [Exemplos]

---

## 4. Regras de Documentação

### 📝 Documentação de Código

#### RN-DOC-001: Keywords Devem Ser Documentadas

**Regra**: Toda keyword customizada deve ter `[Documentation]`

**Obrigatório**:
```robotframework
*** Keywords ***
Realizar Login
    [Documentation]    Faz login com credenciais padrão
    [Documentation]    Valida que usuário está logado
    [Implementação]
```

**Proibido**:
```robotframework
*** Keywords ***
Realizar Login
    [Implementação sem documentação]
```

---

#### RN-DOC-002: Test Cases Devem Ser Documentados

**Regra**: Test cases complexos devem ter `[Documentation]`

**Recomendado para**:
- Testes com mais de [X] passos
- Testes com lógica condicional
- Testes que validam regras de negócio específicas

---

## 5. Regras de Manutenibilidade

### 🔧 Código Limpo

#### RN-MAN-001: Proibido Sleep Hardcoded

**Regra**: Usar `Wait Until` ao invés de `Sleep`

**Violação**:
```robotframework
❌ Sleep    5s
```

**Correto**:
```robotframework
✅ Wait Until Element Is Visible    ${locator}    timeout=20s
```

**Exceção**: [Especificar se há exceção]

---

#### RN-MAN-002: Proibido Locators Hardcoded

**Regra**: Locators devem estar em Page Objects

**Violação**:
```robotframework
❌ Click Element    xpath=//button[@id='submit']
```

**Correto**:
```robotframework
✅ ${locator}=    Obter Localizador Botão Submit
✅ Click Element    ${locator}
```

---

#### RN-MAN-003: [Regra DRY]

**Regra**: Não repetir código [X] vezes

**Ação**: Criar keyword reutilizável

---

## 6. Regras de Execução

### ⚙️ Testes Independentes

#### RN-EXE-001: Testes Devem Ser Independentes

**Regra**: Cada teste deve funcionar isoladamente

**Obrigatório**:
- Setup próprio
- Teardown próprio
- Não depender de estado de outro teste

**Validação**: Executar testes em ordem aleatória

---

#### RN-EXE-002: [Regra de Timeout]

**Regra**: Usar timeouts consistentes

**Padrão**:
- Elementos comuns: [X]s
- Carregamento: [Y]s
- Ações complexas: [Z]s

---

## 7. Regras de Tags

### 🏷️ Sistema de Tags

#### RN-TAG-001: Tags Obrigatórias

**Regra**: Todo teste deve ter pelo menos:
- [Prioridade]: `P0`, `P1`, `P2`
- [Categoria]: `smoke`, `regression`, `sanity`

**Exemplo**:
```robotframework
*** Test Cases ***
Login Com Sucesso
    [Tags]    P0    smoke    login
    [Passos]
```

---

## 8. Regras de Revisão de Código

### 👀 Code Review

#### RN-REV-001: Checklist Obrigatório

**Antes de Merge**:
- [ ] Segue RN-NOM (nomenclatura)
- [ ] Segue RN-EST (estruturação)
- [ ] Segue RN-VAL (validação)
- [ ] Segue RN-DOC (documentação)
- [ ] Segue RN-MAN (manutenibilidade)
- [ ] Testes passando
- [ ] Sem arquivos .md adicionais (RN-ARQ-001)

---

## 9. Exceções e Aprovações

### 🎫 Quando Quebrar Regras

#### RN-EXC-001: Processo de Exceção

**Como solicitar exceção**:
1. [Justificar por que regra não se aplica]
2. [Documentar alternativa]
3. [Obter aprovação de [Lead/Arquiteto]]

**Documentar no código**:
```robotframework
# EXCEÇÃO RN-MAN-001: Justificativa
Sleep    2s    # [Razão específica]
```

---

## 10. Penalidades

### ⚠️ Violações

**Violações Críticas** (bloqueia merge):
- [RN-ARQ-001]: Criar .md indevido
- [RN-MAN-002]: Locators hardcoded
- [RN-EXE-001]: Testes dependentes

**Violações Médias** (requer correção):
- [RN-NOM]: Nomenclatura incorreta
- [RN-DOC]: Falta documentação

**Violações Leves** (recomendação):
- [Formatação]
- [Comentários]

---

## Referências

- PRD: [link]
- SDD: [link]
- Test-Patterns: [link]
- Robot-Conventions: [link]

---

## Histórico de Regras

| ID | Nome | Data | Autor | Status |
|----|------|------|-------|--------|
| RN-ARQ-001 | Restrição .md | [Data] | [Nome] | ✅ Ativa |
| RN-NOM-001 | Nome Test Case | [Data] | [Nome] | ✅ Ativa |

---

## Aprovação

Este documento de regras foi revisado e aprovado por:

| Papel | Nome | Data | Assinatura |
|-------|------|------|------------|
| QA Lead | [Nome] | [Data] | |
| Tech Lead | [Nome] | [Data] | |
