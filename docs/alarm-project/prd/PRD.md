# Product Requirements Document (PRD)

> **Template de Estrutura para Documentação de Requisitos de Produto**  
> Este documento serve como guia e template para criar PRDs de testes automatizados

---

## 📋 Estrutura Obrigatória do PRD

Todo PRD deve conter as seguintes seções:

1. **Visão Geral do Produto** - Contexto e escopo
2. **Objetivo** - Meta clara e mensurável
3. **Abordagem de Testes** - Metodologia utilizada
4. **Funcionalidades a Serem Testadas** - Casos de uso detalhados
5. **Regras de Negócio** - Regras que o sistema deve seguir
6. **Elementos de UI Necessários** - Componentes da interface
7. **Critérios de Aceitação** - Condições para aprovação
8. **Priorização** - Ordem de importância

---

## 1. Visão Geral do Produto

### O que documentar:
- Contexto do aplicativo/sistema
- Escopo específico da funcionalidade
- Plataforma alvo (Android/iOS/Web)

### Exemplo:
```
Este documento define os requisitos para automação de testes do aplicativo 
de Relógio Android, especificamente para a funcionalidade de **criação de 
alarmes com seleção de período AM/PM**.
```

---

## 2. Objetivo

### O que documentar:
- Meta clara e mensurável
- Quantidade de testes
- Funcionalidades específicas

### Exemplo:
```
Implementar **2 casos de teste automatizados** que validem a criação de 
alarmes em formato de 12 horas com seleção correta do período:
1. Criar alarme no período **AM** (manhã)
2. Criar alarme no período **PM** (tarde/noite)
```

---

## 3. Abordagem de Testes

### O que documentar:
- Metodologia escolhida (BDD, TDD, etc)
- Frameworks utilizados
- Estrutura dos testes

### Exemplo:

#### Metodologia: BDD (Behavior Driven Development)

Os testes seguirão o formato Gherkin:
- **Dado** (Given): Pré-condições do sistema
- **Quando** (When): Ação executada pelo usuário
- **Então** (Then): Resultado esperado e validações

---

## 4. Funcionalidades a Serem Testadas

### O que documentar:
- Funcionalidade principal com escopo claro
- Casos de teste individuais
- Objetivo de cada teste
- Comportamento esperado passo a passo

### Formato:

```
### Funcionalidade Principal: [Nome da Funcionalidade]

**Escopo**: [Descrição do que será testado]

#### Caso de Teste N: [Nome do Caso]
- **Objetivo**: [O que o teste valida]
- **Dados de Entrada**: [Valores específicos]
- **Comportamento Esperado**:
  - [Passo 1]
  - [Passo 2]
  - [Resultado final]
```

### Exemplo Prático:

#### Funcionalidade Principal: Criação de Alarmes com Período AM/PM

**Escopo**: Validar a criação de alarmes no formato de 12 horas com seleção explícita de AM ou PM.

##### Caso de Teste 1: Criar Alarme AM
- **Objetivo**: Validar criação de alarme no período da manhã
- **Horário**: 8:30 AM
- **Dados de Entrada**:
  - Hora: 8 (sem zero à esquerda)
  - Minuto: 30
  - Período: AM
- **Comportamento Esperado**:
  - Sistema abre tela de configuração do alarme
  - Usuário configura horário 8:30
  - Sistema exibe spinner AM/PM
  - Usuário seleciona período AM
  - Sistema salva o alarme
  - Alarme aparece na lista com "8:30 AM" (formato padrão Android)

##### Caso de Teste 2: Criar Alarme PM
- **Objetivo**: Validar criação de alarme no período da tarde/noite
- **Horário**: 6:45 PM
- **Dados de Entrada**:
  - Hora: 6 (sem zero à esquerda)
  - Minuto: 45
  - Período: PM
- **Comportamento Esperado**:
  - Sistema abre tela de configuração do alarme
  - Usuário configura horário 6:45 em formato 12h
  - Sistema exibe spinner AM/PM
  - Usuário seleciona período PM
  - Sistema salva o alarme
  - Alarme aparece na lista com "6:45 PM" (formato padrão Android)

---

## 5. Regras de Negócio

### O que documentar:
- Identificador único para cada regra (RN001, RN002...)
- Descrição clara da regra
- Condições e exceções
- Validações necessárias

### Formato:

```
### RN[XXX]: [Nome da Regra]
- [Descrição da regra]
- [Condição 1]
- [Condição 2]
- [Exceções, se houver]
```

### Exemplo Prático:

#### RN001: Formato de 12 Horas
- O aplicativo deve permitir configuração no formato de 12 horas
- O spinner AM/PM deve estar visível e funcional
- A seleção de AM/PM é obrigatória

#### RN002: Validação do Período
- **AM**: Período de 12:00 AM até 11:59 AM (meia-noite até meio-dia)
- **PM**: Período de 12:00 PM até 11:59 PM (meio-dia até meia-noite)

#### RN003: Exibição na Lista
- Alarmes salvos devem aparecer na lista principal
- Formato de exibição: "H:MM AM/PM" (exemplo: "8:30 AM", "6:45 PM")
- Horários devem estar ordenados

#### RN004: Persistência
- Alarmes criados devem permanecer salvos após criação
- Sistema deve manter a configuração de AM/PM

---

## 6. Elementos de UI Necessários

### O que documentar:
- Referência ao documento de Elements
- Lista resumida dos principais elementos
- Agrupamento por função

### Formato:

```
Consulte [Elements.md](Elements.md) para mapeamento completo.

### Elementos Principais
- **[Nome do Elemento]**: [Função]
- **[Nome do Elemento]**: [Função]
```

### Exemplo Prático:

Consulte [Elements.md](Elements.md) para mapeamento completo dos elementos:

#### Elementos Principais
- **Botão Adicionar**: Para criar novo alarme
- **Seletor de Hora**: Para configurar a hora
- **Seletor de Minuto**: Para configurar os minutos
- **Spinner AM/PM**: Para selecionar o período
- **Botão OK/Salvar**: Para confirmar o alarme
- **Lista de Alarmes**: Para validar a criação

---

## 7. Critérios de Aceitação

### O que documentar:
- Condições específicas para cada teste
- Checklist de validações
- Comportamentos obrigatórios

### Formato:

```
### [Nome do Teste]
- ✅ [Critério 1]
- ✅ [Critério 2]
- ✅ [Critério 3]
```

### Exemplo Prático:

#### Teste AM
- ✅ Alarme é criado com sucesso
- ✅ Horário exibido é "8:30 AM"
- ✅ Período AM está corretamente configurado
- ✅ Alarme aparece na lista de alarmes

#### Teste PM
- ✅ Alarme é criado com sucesso
- ✅ Horário exibido é "6:45 PM" 
- ✅ Período PM está corretamente configurado
- ✅ Alarme aparece na lista de alarmes

---

## 8. Priorização

### O que documentar:
- Níveis de prioridade (P0, P1, P2...)
- Funcionalidades por prioridade
- Quantidade de testes estimados

### Formato de Tabela:

| Prioridade | Funcionalidade | Testes | Justificativa |
|------------|---------------|--------|---------------|
| **P0** | [Funcionalidade crítica] | X testes | [Por que é crítico] |
| **P1** | [Funcionalidade importante] | X testes | [Por que é importante] |
| **P2** | [Funcionalidade desejável] | X testes | [Por que é desejável] |

### Exemplo Prático:

| Prioridade | Funcionalidade | Testes | Justificativa |
|------------|---------------|--------|---------------|
| **P0** | Criar alarme AM | 1 teste | Funcionalidade core do aplicativo |
| **P0** | Criar alarme PM | 1 teste | Validação de período é crítica |

**Total de Testes a Implementar: 2**

---

## 💡 Boas Práticas na Elaboração do PRD

1. **Seja Específico**: Use números, valores e exemplos concretos
2. **Seja Mensurável**: Critérios de aceitação devem ser objetivos
3. **Seja Completo**: Todas as seções obrigatórias devem estar preenchidas
4. **Referencie Documentos**: Link para SDD, Elements e outros docs
5. **Use Formatação Consistente**: Mantenha o padrão em todo o documento

---

## 📚 Referências

- [SDD.md](SDD.md): Design técnico da implementação
- [Elements.md](Elements.md): Mapeamento completo de elementos de UI
- [Test-Rules.md](Test-Rules.md): Regras e padrões de testes
- [Test-Patterns.md](Test-Patterns.md): Padrões de implementação
- [Robot-Conventions.md](Robot-Conventions.md): Convenções do Robot Framework
- [infra.md](infra.md): Estrutura do projeto