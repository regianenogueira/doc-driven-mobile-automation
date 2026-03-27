# Test Patterns - [NOME DO PROJETO]

> **Template de Padrões e Anti-Padrões para Testes Automatizados**  
> Documente soluções reutilizáveis e erros comuns

---

## 📋 Como Usar Este Documento

Este documento serve para:
- ✅ Catalogar padrões que funcionaram bem
- ✅ Documentar soluções para problemas comuns
- ✅ Evitar anti-patterns conhecidos
- ✅ Compartilhar conhecimento entre QAs

**Regra**: Sempre que resolver um problema complexo ou descobrir uma solução elegante, documente aqui!

---

## 📂 Categorias

1. **Design Patterns** - Arquitetura e estruturação
2. **Resiliência Patterns** - Testes robustos e confiáveis
3. **Performance Patterns** - Otimização de execução
4. **Manutenibilidade Patterns** - Código fácil de manter
5. **Anti-Patterns** - O que NÃO fazer

---

## 1. Design Patterns

### DP-01: Page Object Pattern

**Categoria**: Design / Estruturação

**Problema**: [Descrição - ex: Locators espalhados dificultam manutenção]

**Solução**: [Descrição - ex: Centralizar locators em Page Objects]

**Implementação**:

```robotframework
# resources/pages/[nome]_page.robot
*** Keywords ***
Obter Localizador [Elemento]
    [Documentation]    [Descrição]
    [Return]    [locator]

# resources/keywords/[nome]_keywords.robot
Clicar em [Elemento]
    ${localizador}=    Obter Localizador [Elemento]
    Click Element    ${localizador}
```

**Benefícios**:
- [Benefício 1]
- [Benefício 2]

**Quando Usar**: [Contexto]

**Quando Não Usar**: [Contexto onde não se aplica]

---

### DP-02: [Nome do Pattern]

**Categoria**: Design

**Problema**: [Descrição]

**Solução**: [Descrição]

**Implementação**:
```robotframework
[Código exemplo]
```

**Benefícios**:
- [Lista]

**Quando Usar**: [Contexto]

---

## 2. Resiliência Patterns

### RP-01: Wait Strategy Pattern

**Categoria**: Resiliência

**Problema**: [ex: Elementos podem levar tempo variável para aparecer]

**Solução**: [ex: Usar waits inteligentes com timeout adequado]

**Implementação**:

```robotframework
*** Keywords ***
Aguardar e Clicar em [Elemento]
    [Documentation]    Aguarda elemento estar visível antes de clicar
    ${locator}=    Obter Localizador [Elemento]
    Wait Until Element Is Visible    ${locator}    timeout=${TIMEOUT_PADRAO}
    Click Element    ${locator}
```

**Benefícios**:
- [Reduz flakiness]
- [Adaptável a diferentes velocidades]

**Quando Usar**: [Sempre que interagir com UI]

**Anti-Pattern Relacionado**: [AP-01: Sleep Hardcoded]

---

### RP-02: Fallback Locator Pattern

**Categoria**: Resiliência

**Problema**: [ex: Locator pode variar entre versões ou idiomas]

**Solução**: [ex: Implementar fallback com múltiplos locators]

**Implementação**:

```robotframework
*** Keywords ***
Obter Localizador [Elemento] Primário
    [Return]    [locator preferencial]

Obter Localizador [Elemento] Secundário
    [Return]    [locator alternativo]

Clicar em [Elemento] com Fallback
    ${locator_primario}=    Obter Localizador [Elemento] Primário
    ${status}=    Run Keyword And Return Status
    ...    Click Element    ${locator_primario}
    
    Run Keyword Unless    ${status}
    ...    Clicar com Locator Secundário

Clicar com Locator Secundário
    ${locator_secundario}=    Obter Localizador [Elemento] Secundário
    Click Element    ${locator_secundario}
```

**Benefícios**:
- [Funciona em múltiplas versões]
- [Mais robusto]

**Quando Usar**: [Quando locator é instável]

---

### RP-03: [Outro Pattern de Resiliência]

**Categoria**: Resiliência

**Problema**: [Descrição]

**Solução**: [Descrição]

**Implementação**:
```robotframework
[Código]
```

---

## 3. Performance Patterns

### PP-01: [Nome do Pattern]

**Categoria**: Performance

**Problema**: [ex: Testes muito lentos]

**Solução**: [ex: Otimizar waits, usar estratégias de cache]

**Implementação**:
```robotframework
[Código]
```

**Benefícios**:
- [Reduz tempo de execução]
- [Melhora feedback]

**Trade-offs**: [Possíveis desvantagens]

**Quando Usar**: [Contexto]

---

## 4. Manutenibilidade Patterns

### MP-01: DRY Keywords

**Categoria**: Manutenibilidade

**Problema**: [ex: Código duplicado em múltiplos lugares]

**Solução**: [ex: Criar keywords reutilizáveis]

**Implementação**:

```robotframework
# ❌ ANTES - Duplicado
Teste 1
    Wait Until Element Is Visible    ${locator}    20s
    Click Element    ${locator}

Teste 2
    Wait Until Element Is Visible    ${locator}    20s
    Click Element    ${locator}

# ✅ DEPOIS - Reutilizável
*** Keywords ***
Aguardar e Clicar
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    20s
    Click Element    ${locator}

*** Test Cases ***
Teste 1
    Aguardar e Clicar    ${locator}

Teste 2
    Aguardar e Clicar    ${locator}
```

**Benefícios**:
- [Mudança em um lugar apenas]
- [Menos código]

**Quando Usar**: [Quando algo se repete 3+ vezes]

---

### MP-02: [Outro Pattern de Manutenibilidade]

**Categoria**: Manutenibilidade

**Problema**: [Descrição]

**Solução**: [Descrição]

**Implementação**:
```robotframework
[Código]
```

---

## 5. Anti-Patterns (O que NÃO fazer)

### AP-01: Sleep Hardcoded

**Categoria**: Anti-Pattern / Resiliência

**Problema**: [ex: Usar Sleep com tempo fixo]

**Por que é Ruim**:
- [Torna testes lentos]
- [Não garante que elemento estará pronto]
- [Tempo desperdiçado]

**Código Problemático**:
```robotframework
# ❌ EVITAR
Click Element    ${botao}
Sleep    5s
Input Text    ${campo}    texto
```

**Solução Correta**:
```robotframework
# ✅ CORRETO
Click Element    ${botao}
Wait Until Element Is Visible    ${campo}    timeout=20s
Input Text    ${campo}    texto
```

**Exceções**: [Quando Sleep é aceitável, se houver]

---

### AP-02: Locators Hardcoded

**Categoria**: Anti-Pattern / Design

**Problema**: [ex: Locators espalhados pelo código]

**Por que é Ruim**:
- [Dificulta manutenção]
- [Mudança de UI quebra múltiplos testes]

**Código Problemático**:
```robotframework
# ❌ EVITAR
Click Element    xpath=//button[@id='submit']
Input Text    id=email    user@example.com
```

**Solução Correta**:
```robotframework
# ✅ CORRETO - Page Object
${locator_botao}=    Obter Localizador Botão Submit
${locator_email}=    Obter Localizador Campo Email
Click Element    ${locator_botao}
Input Text    ${locator_email}    user@example.com
```

---

### AP-03: [Outro Anti-Pattern]

**Categoria**: Anti-Pattern

**Problema**: [Descrição]

**Por que é Ruim**:
- [Razão 1]
- [Razão 2]

**Código Problemático**:
```robotframework
# ❌ EVITAR
[Exemplo ruim]
```

**Solução Correta**:
```robotframework
# ✅ CORRETO
[Exemplo bom]
```

---

## 6. Patterns Específicos do Projeto

### [NOME]-01: [Pattern Específico]

**Categoria**: [Categoria]

**Contexto Específico**: [Quando este pattern se aplica especificamente ao seu projeto]

**Problema**: [Descrição]

**Solução**: [Descrição]

**Implementação**:
```robotframework
[Código]
```

---

## 7. Lições Aprendidas

### Lição 1: [Título]

**Situação**: [O que aconteceu]

**Problema**: [O que deu errado]

**Solução Aplicada**: [Como resolvemos]

**Pattern Criado**: [Link para pattern acima, se houver]

**Data**: [Quando isso aconteceu]

---

### Lição 2: [Título]

[Mesma estrutura]

---

## Histórico de Patterns

| ID | Nome | Data Adicionado | Autor | Status |
|----|------|-----------------|-------|--------|
| DP-01 | Page Object | [Data] | [Nome] | ✅ Ativo |
| RP-01 | Wait Strategy | [Data] | [Nome] | ✅ Ativo |
| AP-01 | Sleep Hardcoded | [Data] | [Nome] | ⚠️ Evitar |

**Status**:
- ✅ Ativo: Padrão recomendado
- ⚠️ Evitar: Anti-pattern
- 🔄 Em revisão: Sendo avaliado
- ❌ Depreciado: Não usar mais

---

## Referências

- [Link para documentação externa]
- [Link para padrões da indústria]
- PRD: [link]
- SDD: [link]
