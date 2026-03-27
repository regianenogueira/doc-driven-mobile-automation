# Mapeamento de Elementos - [NOME DO APLICATIVO]

> **Template para Documentação de Elementos de UI**  
> Substitua os textos entre [colchetes] com informações do seu projeto

---

## 📋 Informações do Documento

- **Aplicativo**: [Nome do App/Sistema]
- **Plataforma**: [Android / iOS / Web]
- **Versão Testada**: [X.X.X]
- **Data**: [Data de Criação]
- **Autor**: [Nome do QA]

---

## ⚠️ Importante: Verificação Inicial do Aplicativo

**REGRA**: Após executar `Open Application` ou acessar uma página, é **obrigatório** aguardar que um elemento da tela principal esteja visível antes de prosseguir.

### Elemento Recomendado para Verificação Inicial

**Elemento**: [Nome do elemento sempre visível na tela inicial]

**Por que este elemento?**
- ✅ Sempre visível na [tela principal / homepage]
- ✅ Único e confiável
- ✅ Usa [content-desc / id estável / atributo confiável]
- ✅ Independente de idioma

**Como usar**:
```robotframework
# CORRETO ✅
Open Application    ${SERVER}    &{CAPABILITIES}
${locator}=    Obter Localizador [Elemento de Verificação]
Wait Until Element Is Visible    ${locator}    timeout=[X]s
```

**Localizador**: `[xpath/id/css do elemento]`

---

## 📂 Organização dos Elementos

Os elementos estão organizados por:
1. **Navegação Principal** - Menus, tabs, headers
2. **[Tela/Módulo 1]** - Elementos específicos da primeira tela
3. **[Tela/Módulo 2]** - Elementos específicos da segunda tela
4. **Elementos Comuns** - Botões de ação, mensagens, dialogs

---

## 1. Navegação Principal

### 1.1 [Nome do Elemento de Navegação]
- **Descrição**: [Função do elemento - ex: Ícone para abrir o menu principal]
- **Localizador**: `[xpath/id/css]`
- **Tipo**: [Button / Link / Tab / Icon]
- **Observações**: [Notas importantes sobre comportamento]

### 1.2 [Nome do Elemento de Navegação]
- **Descrição**: [Função]
- **Localizador**: `[xpath/id/css]`
- **Tipo**: [Button / Link / Tab]
- **Observações**: 
  - [Nota 1]
  - [Nota 2]

---

## 2. [Nome da Tela/Módulo Principal]

### 2.1 [Nome do Elemento]
- **Descrição**: [Função do elemento]
- **Localizador**: `[xpath/id/css]`
- **Tipo**: [Button / TextField / Dropdown / etc]
- **Estados**:
  - Normal: [comportamento padrão]
  - Ativo: [comportamento quando ativo]
  - Desabilitado: [comportamento quando desabilitado]
- **Observações**: [Notas importantes]

### 2.2 [Nome do Elemento - Campo de Entrada]
- **Descrição**: [Função - ex: Campo onde o usuário insere email]
- **Localizador**: `[xpath/id/css]`
- **Tipo**: TextField / Input
- **Validações**:
  - Formato esperado: [ex: email@domain.com]
  - Tamanho máximo: [X caracteres]
  - Obrigatório: [Sim/Não]
- **Observações**: [Comportamento especial]

### 2.3 [Nome do Elemento - Botão de Ação]
- **Descrição**: [Função - ex: Botão para submeter formulário]
- **Localizador**: `[xpath/id/css]`
- **Tipo**: Button
- **Ação**: [O que acontece ao clicar]
- **Observações**: 
  - [Pode estar desabilitado se formulário incompleto]
  - [Pode mostrar loading após clique]

---

## 3. [Nome de Outra Tela/Modal]

### 3.1 [Nome do Elemento]
- **Descrição**: [Função]
- **Localizador**: `[xpath/id/css]`
- **Tipo**: [Tipo do elemento]
- **Observações**: [Notas]

### 3.2 [Nome do Elemento - Dropdown/Spinner]
- **Descrição**: [Função - ex: Seletor de categoria]
- **Localizador (Container)**: `[xpath/id/css do container]`
- **Localizador (Opção)**: `[xpath/id/css de uma opção]`
- **Tipo**: Dropdown / Spinner / Select
- **Opções Disponíveis**:
  - [Opção 1]
  - [Opção 2]
  - [Opção 3]
- **Como Selecionar**:
  ```robotframework
  # [Passos para selecionar]
  ```

---

## 4. Elementos de Validação e Feedback

### 4.1 [Mensagem de Sucesso]
- **Descrição**: [Mensagem exibida quando ação é bem-sucedida]
- **Localizador**: `[xpath/id/css]`
- **Tipo**: Text / Toast / Alert
- **Texto Esperado**: "[Texto exato da mensagem]"
- **Duração**: [Permanente / X segundos]
- **Observações**: [Como aparece/desaparece]

### 4.2 [Mensagem de Erro]
- **Descrição**: [Mensagem exibida quando há erro]
- **Localizador**: `[xpath/id/css]`
- **Tipo**: Text / Alert / Dialog
- **Possíveis Textos**:
  - "[Erro tipo 1]"
  - "[Erro tipo 2]"
  - "[Erro tipo 3]"
- **Observações**: [Como tratar]

### 4.3 [Elemento de Loading/Progress]
- **Descrição**: [Indicador de carregamento]
- **Localizador**: `[xpath/id/css]`
- **Tipo**: ProgressBar / Spinner
- **Observações**: [Quando aparece, como aguardar desaparecimento]

---

## 5. Elementos Comuns (Globais)

### 5.1 [Botão Voltar]
- **Descrição**: [Botão para voltar à tela anterior]
- **Localizador**: `[xpath/id/css]`
- **Tipo**: Button / Icon
- **Observações**: [Disponível em quais telas]

### 5.2 [Botão Fechar]
- **Descrição**: [Botão para fechar modal/dialog]
- **Localizador**: `[xpath/id/css]`
- **Tipo**: Button / Icon
- **Observações**: [Comportamento]

### 5.3 [Botão Confirmar]
- **Descrição**: [Botão de confirmação em dialogs]
- **Localizador**: `[xpath/id/css]`
- **Tipo**: Button
- **Textos Possíveis**: "[OK / Confirmar / Sim / Outro]"

### 5.4 [Botão Cancelar]
- **Descrição**: [Botão de cancelamento em dialogs]
- **Localizador**: `[xpath/id/css]`
- **Tipo**: Button
- **Textos Possíveis**: "[Cancelar / Não / Fechar / Outro]"

---

## 6. Elementos Dinâmicos

### 6.1 [Nome do Elemento Dinâmico]
- **Descrição**: [Elemento que muda baseado em condição]
- **Localizador Base**: `[xpath/id/css]`
- **Variações**:
  - **Variação 1**: `[localizador]` - [Quando aparece]
  - **Variação 2**: `[localizador]` - [Quando aparece]
- **Estratégia de Fallback**:
  ```robotframework
  # [Como implementar fallback]
  ```

---

## 7. Notas sobre Locators

### ⚠️ Problemas Conhecidos

#### Variação de Atributos
**Problema**: [Descrição do problema - ex: Android pode armazenar texto em diferentes atributos]

**Elementos Afetados**: 
- [Elemento 1]
- [Elemento 2]

**Solução**: 
```robotframework
# [Implementação da solução com fallback]
```

#### Elementos Dependentes de Idioma
**Elementos que mudam com idioma**:
- [Elemento 1]: [Como lidar]
- [Elemento 2]: [Como lidar]

**Recomendação**: Usar [Accessibility ID / Content-desc / ID] quando possível

#### Elementos Dependentes de Versão
**Mudanças conhecidas entre versões**:
- **Versão [X.X]**: [Localizador antigo]
- **Versão [Y.Y]+**: [Localizador novo]

---

## 8. Estratégias de Locators

### Ordem de Preferência

1. **Accessibility ID / Content-desc** ⭐ Preferencial
   - Independente de idioma
   - Estável entre versões
   - Exemplo: `content-desc="[valor]"`

2. **Resource ID / ID** ⭐ Recomendado
   - Único e estável
   - Exemplo: `id="[package]:id/[nome]"`

3. **XPath com Atributos Únicos** ⚠️ Usar com cautela
   - Quando os acima não estão disponíveis
   - Exemplo: `//[tag][@[atributo]="[valor]"]`

4. **XPath Hierárquico** ❌ Último recurso
   - Frágil, quebra facilmente
   - Usar apenas se necessário

### Exemplos de Bons Locators

```robotframework
# MELHOR - Accessibility ID
accessibility id=login_button

# BOM - Resource ID
id=com.app:id/login_button

# ACEITÁVEL - XPath com atributo único
xpath=//button[@content-desc="Login"]

# EVITAR - XPath hierárquico complexo
xpath=//div[1]/form/div[2]/button[1]
```

---

## 9. Mapeamento de Fluxos

### Fluxo 1: [Nome do Fluxo Principal]

**Elementos Utilizados na Ordem**:
1. [Elemento 1] → [Ação]
2. [Elemento 2] → [Ação]
3. [Elemento 3] → [Ação]
4. [Elemento 4] → [Validação]

### Fluxo 2: [Nome de Outro Fluxo]

**Elementos Utilizados na Ordem**:
1. [Elemento A] → [Ação]
2. [Elemento B] → [Ação]
3. [Elemento C] → [Validação]

---

## 10. Tabela Resumida de Elementos

| ID | Nome | Tipo | Localizador | Tela | Crítico |
|----|------|------|-------------|------|---------|
| E01 | [Nome] | [Tipo] | `[locator]` | [Tela] | ✅ / ❌ |
| E02 | [Nome] | [Tipo] | `[locator]` | [Tela] | ✅ / ❌ |
| E03 | [Nome] | [Tipo] | `[locator]` | [Tela] | ✅ / ❌ |

**Legenda**:
- **Crítico ✅**: Elemento essencial para testes principais
- **Crítico ❌**: Elemento secundário ou opcional

---

## 11. Ferramentas de Inspeção

### Como Obter Locators

**[Android]**:
- Ferramenta: [Appium Inspector / uiautomatorviewer]
- Comando: `[comando para capturar hierarquia]`

**[iOS]**:
- Ferramenta: [Appium Inspector / Accessibility Inspector]
- Comando: `[comando]`

**[Web]**:
- Ferramenta: [DevTools / Selector Hub]
- Atalho: `[F12 / Cmd+Opt+I]`

### Validação de Locators

**Antes de documentar, valide**:
```robotframework
# [Código para testar locator]
```

---

## Glossário

| Termo | Definição |
|-------|-----------|
| XPath | [Definição] |
| Resource ID | [Definição] |
| Content-desc | [Definição] |
| Accessibility ID | [Definição] |

---

## Histórico de Revisões

| Versão | Data | Autor | Elementos Adicionados/Modificados |
|--------|------|-------|-----------------------------------|
| 1.0 | [Data] | [Nome] | Criação inicial |
| | | | |

---

## Referências

- PRD: [link para PRD.md]
- SDD: [link para SDD.md]
- [Documentação de Locator Strategy](URL)
