*** Settings ***
Documentation     Testes automatizados para funcionalidade de Alarmes do aplicativo de Relógio Android
...               Valida criação de alarmes com período AM/PM em formato de 12 horas
...               
...               METODOLOGIA: BDD (Behavior Driven Development)
...               FORMATO: Gherkin (Dado/Quando/Então)
...               PRIORIDADE: P0 (Funcionalidade crítica)
...               
...               PRÉ-REQUISITOS:
...               - Dispositivo Android configurado em formato de 12 horas
...               - Servidor Appium rodando em localhost:4723
...               - Aplicativo de Relógio instalado (com.google.android.deskclock)
...               
...               REFERÊNCIAS:
...               - PRD: docs/alarm-project/prd/PRD.md
...               - SDD: docs/alarm-project/ssd/SDD.md
...               - Elements: docs/alarm-project/elements/Elements.md

Library           AppiumLibrary
Resource          ../resources/keywords/alarm_keywords.robot

Suite Setup       Abrir Aplicativo de Relógio
Suite Teardown    Fechar Aplicativo

Test Tags         alarme    android    funcional    p0

*** Variables ***
# Variáveis para o teste AM
# Seguindo recomendação: usar hora SEM zero à esquerda (formato padrão Android)
${HORA_AM}        8
${MINUTO_AM}      30

# Variáveis para o teste PM
${HORA_PM}        6
${MINUTO_PM}      45

*** Test Cases ***
Criar Alarme no Período AM
    [Documentation]    Valida a criação de alarme no período da manhã (AM)
    ...                
    ...                OBJETIVO: Verificar que o usuário consegue criar um alarme para 8:30 AM
    ...                e que este alarme aparece corretamente na lista de alarmes
    ...                
    ...                DADOS DE ENTRADA:
    ...                - Hora: 8 (sem zero à esquerda)
    ...                - Minuto: 30
    ...                - Período: AM
    ...                
    ...                RESULTADO ESPERADO:
    ...                - Alarme criado com sucesso
    ...                - Alarme exibido na lista como "8:30 AM"
    ...                
    ...                REGRAS DE NEGÓCIO:
    ...                - RN001: Formato de 12 horas
    ...                - RN002: Validação do Período AM (12:00 AM até 11:59 AM)
    ...                - RN003: Exibição na lista
    ...                
    ...                REFERÊNCIA: PRD.md - Caso de Teste 1
    
    [Tags]    am    smoke    regressao
    
    Dado que o aplicativo de Relógio está aberto
    Quando o usuário cria um alarme para ${HORA_AM}:${MINUTO_AM} AM
    Então o alarme ${HORA_AM}:${MINUTO_AM} AM deve aparecer na lista

Criar Alarme no Período PM
    [Documentation]    Valida a criação de alarme no período da tarde/noite (PM)
    ...                
    ...                OBJETIVO: Verificar que o usuário consegue criar um alarme para 6:45 PM
    ...                e que este alarme aparece corretamente na lista de alarmes
    ...                
    ...                DADOS DE ENTRADA:
    ...                - Hora: 6 (sem zero à esquerda)
    ...                - Minuto: 45
    ...                - Período: PM
    ...                
    ...                RESULTADO ESPERADO:
    ...                - Alarme criado com sucesso
    ...                - Alarme exibido na lista como "6:45 PM"
    ...                - Período PM corretamente configurado
    ...                
    ...                REGRAS DE NEGÓCIO:
    ...                - RN001: Formato de 12 horas
    ...                - RN002: Validação do Período PM (12:00 PM até 11:59 PM)
    ...                - RN003: Exibição na lista
    ...                
    ...                REFERÊNCIA: PRD.md - Caso de Teste 2
    
    [Tags]    pm    smoke    regressao
    
    Dado que o aplicativo de Relógio está aberto
    Quando o usuário cria um alarme para ${HORA_PM}:${MINUTO_PM} PM
    Então o alarme ${HORA_PM}:${MINUTO_PM} PM deve aparecer na lista

*** Keywords ***
# ==========================================
# KEYWORDS BDD (BRIDGE PATTERN)
# ==========================================
# Estas keywords fazem a ponte entre a linguagem de negócio (Gherkin)
# e as keywords técnicas de implementação

Dado que o aplicativo de Relógio está aberto
    [Documentation]    Pré-condição: Aplicativo já foi aberto no Suite Setup
    ...                Esta keyword serve apenas para dar contexto ao teste em formato BDD
    ...                A abertura real do aplicativo acontece no Suite Setup
    
    Log    Pré-condição: Aplicativo de Relógio está aberto e pronto    level=INFO
    
    # Validar que realmente está na tela correta
    ${localizador_fab}=    Obter Localizador Botão Adicionar Alarme
    Wait Until Element Is Visible    ${localizador_fab}    timeout=20s

Quando o usuário cria um alarme para ${hora}:${minuto} ${periodo}
    [Documentation]    Ação: Usuário cria um novo alarme com hora, minuto e período especificados
    ...                Chama a keyword de alto nível que implementa toda a lógica de criação
    
    Log    Ação: Criando alarme ${hora}:${minuto} ${periodo}    level=INFO
    Criar Alarme Com Período    ${hora}    ${minuto}    ${periodo}

Então o alarme ${hora}:${minuto} ${periodo} deve aparecer na lista
    [Documentation]    Verificação: Alarme criado deve estar visível na lista de alarmes
    ...                Valida que o alarme foi salvo corretamente e está exibido no formato esperado
    
    Log    Verificação: Validando alarme ${hora}:${minuto} ${periodo} na lista    level=INFO
    Validar Alarme Criado    ${hora}    ${minuto}    ${periodo}
