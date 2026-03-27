# Template de Documentação QA

Este template fornece uma estrutura completa para documentar projetos de automação de testes.

## 📂 Estrutura

```
template/
├── prd/
│   └── PRD_TEMPLATE.md          # Product Requirements Document
├── ssd/
│   └── SDD_TEMPLATE.md          # Software Design Document
├── elements/
│   └── ELEMENTS_TEMPLATE.md    # Mapeamento de Elementos de UI
├── test-knowledge/
│   ├── ROBOT_CONVENTIONS_TEMPLATE.md  # Convenções do Robot Framework
│   ├── TEST_PATTERNS_TEMPLATE.md      # Padrões de Testes
│   └── TEST_RULES_TEMPLATE.md         # Regras de Testes
└── guia-metodologia-qa.html     # Guia interativo para QAs
```

## 🚀 Como Usar

### 1. Para Novo Projeto

1. Copie toda a pasta `template` para uma nova pasta com o nome do seu projeto
2. Exemplo: `cp -r template/ login-project/`
3. Renomeie os arquivos removendo o `_TEMPLATE`:
   - `PRD_TEMPLATE.md` → `PRD.md`
   - `SDD_TEMPLATE.md` → `SDD.md`
   - etc.
4. Preencha cada documento seguindo as instruções dentro dele

### 2. Para Compartilhar com Outros QAs

1. Abra o arquivo `guia-metodologia-qa.html` em um navegador
2. Use-o como material de treinamento
3. Cada seção tem links diretos para os templates correspondentes

### 3. Ordem Recomendada de Preenchimento

1. **PRD** - Defina O QUE será testado
2. **Elements** - Mapeie os elementos de UI necessários
3. **SDD** - Planeje COMO implementar tecnicamente
4. **Test Knowledge** - Revise e adapte padrões para seu contexto

## 📋 Checklist de Documentação

- [ ] PRD completo com todos os casos de teste
- [ ] Elements mapeados com locators validados
- [ ] SDD com stack tecnológico definido
- [ ] Test Knowledge revisado e adaptado
- [ ] Estrutura de pastas do projeto criada
- [ ] README.md do projeto com instruções de execução

## 💡 Dicas

- **Mantenha atualizado**: Documentação desatualizada é pior que sem documentação
- **Use placeholders**: Substitua `[NOME_DO_PROJETO]` pelo nome real
- **Adapte conforme necessário**: Estes são templates, não regras rígidas
- **Evite duplicação**: Não crie arquivos .md adicionais além do README.md do projeto

## 🔗 Recursos

- [Guia Visual HTML](guia-metodologia-qa.html) - Abra em um navegador
- [Exemplo Completo](../alarm-project/) - Projeto de referência completo
