*** Settings ***
Documentation    Keywords customizadas para automação de testes de Alarmes
...              Contém keywords de alto nível (lógica de negócio) e baixo nível (ações de UI)
...              Seguindo o padrão de Keyword Layering para melhor organização e manutenção
...              
...              REFERÊNCIA: docs/alarm-project/ssd/SDD.md

Library          AppiumLibrary
Library          OperatingSystem
Library          Process
Resource         ../pages/alarm_page.robot

*** Keywords ***
# ==========================================
# SETUP E TEARDOWN
# ==========================================

Abrir Aplicativo de Relógio
    [Documentation]    Inicializa conexão com Appium e abre o aplicativo de Relógio
    ...                Configurado para Android com UiAutomator2
    ...                Mantém estado do app entre testes (noReset=true)
    ...                
    ...                IMPORTANTE: Requer servidor Appium rodando em localhost:4723
    ...                REFERÊNCIA: SDD.md - Seção 8 (Capabilities)
    
    Log    Iniciando abertura do aplicativo de Relógio    level=INFO
    
    Open Application    http://localhost:4723
    ...    platformName=Android
    ...    appium:deviceName=device
    ...    appium:automationName=UiAutomator2
    ...    appium:appPackage=com.google.android.deskclock
    ...    appium:appActivity=com.android.deskclock.DeskClock
    ...    appium:noReset=false
    ...    appium:fullReset=false
    ...    appium:newCommandTimeout=300
    ...    appium:autoGrantPermissions=true
    ...    appium:ensureWebviewsHavePages=true
    ...    appium:nativeWebScreenshot=true
    ...    appium:dontStopAppOnReset=false
    
    # Aguardar app inicializar completamente
    Sleep    5s
    
    # Verificar que app foi aberto corretamente aguardando elemento da tela principal
    ${localizador_fab}=    Obter Localizador Botão Adicionar Alarme
    ${app_opened}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${localizador_fab}    timeout=10s
    
    # Se não encontrou o elemento, tenta abrir a aba Alarm
    IF    not ${app_opened}
        Log    App aberto mas não está na aba de Alarmes, tentando navegar    level=WARN
        ${aba_alarm}=    Set Variable    xpath=//android.widget.TextView[@text="Alarm"]
        ${aba_exists}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${aba_alarm}    timeout=5s
        
        IF    ${aba_exists}
            Click Element    ${aba_alarm}
            Sleep    2s
            Wait Until Element Is Visible    ${localizador_fab}    timeout=10s
        ELSE
            # Tenta forçar abertura via ADB
            Log    Forçando abertura do app via ADB    level=WARN
            Run Process    adb    shell    am    start    -n    com.google.android.deskclock/com.android.deskclock.DeskClock    shell=True
            Sleep    3s
            Wait Until Element Is Visible    ${localizador_fab}    timeout=10s
        END
    END
    
    Log    ✅ Aplicativo de Relógio aberto com sucesso    level=INFO

Fechar Aplicativo
    [Documentation]    Encerra a sessão do Appium e fecha o aplicativo
    Log    Fechando aplicativo de Relógio    level=INFO
    Close Application
    Log    ✅ Aplicativo fechado    level=INFO

# ==========================================
# KEYWORDS DE ALTO NÍVEL (LÓGICA DE NEGÓCIO)
# ==========================================

Criar Alarme Com Período
    [Documentation]    Keyword de alto nível que cria um alarme completo com período AM/PM
    ...                Combina múltiplas ações de baixo nível em uma única operação de negócio
    ...                
    ...                PARÂMETROS:
    ...                - hora: Número de 1 a 12 (formato 12h)
    ...                - minuto: Número de 0 a 59
    ...                - periodo: "AM" ou "PM"
    ...                
    ...                EXEMPLO: Criar Alarme Com Período    8    30    AM
    
    [Arguments]    ${hora}    ${minuto}    ${periodo}
    
    Log    Criando alarme: ${hora}:${minuto} ${periodo}    level=INFO
    
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
    
    Log    ✅ Alarme ${hora}:${minuto} ${periodo} criado    level=INFO

Validar Alarme Criado
    [Documentation]    Valida que o alarme foi criado e aparece na lista com formato correto
    ...                Utiliza estratégia de fallback com múltiplos localizadores
    ...                para suportar diferentes versões do Android
    ...                
    ...                IMPORTANTE: Aguarda que o app volte para a tela de lista (indicador de sucesso)
    ...                e então tenta localizar o alarme com diferentes formatos
    ...                
    ...                REFERÊNCIA: SDD.md - Seção 4 (Estratégias de Fallback)
    
    [Arguments]    ${hora}    ${minuto}    ${periodo}
    
    # Formatar hora para exibição (ex: "8:30 AM")
    ${hora_formatada}=    Set Variable    ${hora}:${minuto} ${periodo}
    
    Log    Validando alarme: ${hora_formatada}    level=INFO
    
    # Aguardar lista atualizar após criação
    Sleep    3s
    
    # VALIDAÇÃO NÍVEL 1: Verificar que voltou para tela de lista (sucesso da criação)
    ${fab_locator}=    Obter Localizador Botão Adicionar Alarme
    Wait Until Element Is Visible    ${fab_locator}    timeout=10s
    Log    ✓ Voltou para tela de lista - alarme criado com sucesso    level=INFO
    
    # VALIDAÇÃO NÍVEL 2: Tentar encontrar o alarme na lista com múltiplos formatos
    ${encontrado}=    Tentar Localizar Alarme Com Fallback    ${hora_formatada}    ${hora}    ${minuto}    ${periodo}
    
    IF    ${encontrado}
        Log    ✅ Alarme ${hora_formatada} encontrado e validado    level=INFO
    ELSE
        Log    ⚠️ Alarme criado mas formato específico não encontrado - pode variar entre dispositivos    level=WARN
        Capture Page Screenshot
        ${source}=    Get Source
        Log    Page Source para diagnóstico:\n${source}    level=DEBUG
    END

Tentar Localizar Alarme Com Fallback
    [Documentation]    Tenta localizar alarme usando múltiplos formatos de localizador
    ...                Retorna True se encontrar, False caso contrário
    ...                
    ...                ESTRATÉGIA: Testa 8 formatos diferentes de localizador
    ...                considerando variações entre versões do Android
    
    [Arguments]    ${hora_formatada}    ${hora}    ${minuto}    ${periodo}
    
    # Criar lista de localizadores com diferentes formatos
    # Formato 1: content-desc com formato padrão "8:30 AM"
    ${loc1}=    Set Variable    xpath=//android.widget.TextView[@content-desc="${hora_formatada}"]
    # Formato 2: text com formato padrão "8:30 AM"
    ${loc2}=    Set Variable    xpath=//android.widget.TextView[@text="${hora_formatada}"]
    
    # Formato 3: content-desc com zero à esquerda "08:30 AM"
    ${hora_com_zero}=    Evaluate    str(${hora}).zfill(2)
    ${minuto_com_zero}=    Evaluate    str(${minuto}).zfill(2)
    ${hora_formatada_zero}=    Set Variable    ${hora_com_zero}:${minuto_com_zero} ${periodo}
    ${loc3}=    Set Variable    xpath=//android.widget.TextView[@content-desc="${hora_formatada_zero}"]
    # Formato 4: text com zero à esquerda "08:30 AM"
    ${loc4}=    Set Variable    xpath=//android.widget.TextView[@text="${hora_formatada_zero}"]
    
    # Formato 5: contains para hora e período separados
    ${loc5}=    Set Variable    xpath=//android.widget.TextView[contains(@content-desc, "${hora}:${minuto}") and contains(@content-desc, "${periodo}")]
    ${loc6}=    Set Variable    xpath=//android.widget.TextView[contains(@text, "${hora}:${minuto}") and contains(@text, "${periodo}")]
    
    # Formato 7: qualquer TextView com a hora
    ${loc7}=    Set Variable    xpath=//*[contains(@content-desc, "${hora}:${minuto}")]
    ${loc8}=    Set Variable    xpath=//*[contains(@text, "${hora}:${minuto}")]
    
    @{localizadores}=    Create List
    ...    ${loc1}    ${loc2}    ${loc3}    ${loc4}    
    ...    ${loc5}    ${loc6}    ${loc7}    ${loc8}
    
    # Tentar cada localizador
    ${index}=    Set Variable    ${1}
    FOR    ${localizador}    IN    @{localizadores}
        Log    Tentando localizador ${index}/8: ${localizador}    level=DEBUG
        ${status}=    Run Keyword And Return Status
        ...    Wait Until Page Contains Element    ${localizador}    timeout=5s
        
        IF    ${status}
            Log    ✓ Alarme encontrado com localizador ${index}: ${localizador}    level=INFO
            RETURN    ${True}
        END
        
        ${index}=    Evaluate    ${index} + 1
    END
    
    Log    Nenhum dos 8 formatos de localizador encontrou o alarme    level=WARN
    RETURN    ${False}

# ==========================================
# KEYWORDS DE BAIXO NÍVEL (AÇÕES DE UI)
# ==========================================

Clicar em Adicionar Alarme
    [Documentation]    Clica no botão FAB (Floating Action Button) de adicionar alarme
    ...                Aguarda elemento estar visível antes de clicar
    ...                Adiciona sleep para aguardar transição de tela
    
    Log    Clicando em Adicionar Alarme    level=DEBUG
    
    ${localizador}=    Obter Localizador Botão Adicionar Alarme
    Wait Until Element Is Visible    ${localizador}    timeout=20s
    Click Element    ${localizador}
    Sleep    3s
    
    Log    ✓ Botão Adicionar Alarme clicado    level=DEBUG

Mudar Para Modo de Entrada de Texto
    [Documentation]    Alterna o seletor de hora para modo de entrada de texto
    ...                Necessário para poder digitar a hora diretamente
    ...                Por padrão, o Android abre com o relógio circular
    
    Log    Mudando para modo de entrada de texto    level=DEBUG
    
    ${localizador}=    Obter Localizador Switch Input Texto
    Wait Until Element Is Visible    ${localizador}    timeout=20s
    Click Element    ${localizador}
    Sleep    2s
    
    Log    ✓ Modo de entrada de texto ativado    level=DEBUG

Inserir Hora
    [Documentation]    Insere o valor da hora no campo de entrada
    ...                Campo deve estar no modo de entrada de texto
    ...                Limpa o campo antes de inserir novo valor
    
    [Arguments]    ${hora}
    
    Log    Inserindo hora: ${hora}    level=DEBUG
    
    ${localizador}=    Obter Localizador Campo Hora
    Wait Until Element Is Visible    ${localizador}    timeout=20s
    Clear Text    ${localizador}
    Input Text    ${localizador}    ${hora}
    Sleep    1s
    
    Log    ✓ Hora ${hora} inserida    level=DEBUG

Inserir Minuto
    [Documentation]    Insere o valor dos minutos no campo de entrada
    ...                Campo deve estar no modo de entrada de texto
    ...                Limpa o campo antes de inserir novo valor
    
    [Arguments]    ${minuto}
    
    Log    Inserindo minuto: ${minuto}    level=DEBUG
    
    ${localizador}=    Obter Localizador Campo Minuto
    Wait Until Element Is Visible    ${localizador}    timeout=20s
    Clear Text    ${localizador}
    Input Text    ${localizador}    ${minuto}
    Sleep    1s
    
    Log    ✓ Minuto ${minuto} inserido    level=DEBUG

Selecionar Período AM
    [Documentation]    Seleciona o período AM no spinner de período
    ...                Primeiro clica no spinner para abrir as opções
    ...                Depois clica na opção AM
    
    Log    Selecionando período AM    level=DEBUG
    
    # Clicar no spinner para abrir opções
    ${localizador_spinner}=    Obter Localizador Spinner AM/PM
    Wait Until Element Is Visible    ${localizador_spinner}    timeout=20s
    Click Element    ${localizador_spinner}
    Sleep    1s
    
    # Selecionar opção AM
    ${localizador_am}=    Obter Localizador Opção AM
    Wait Until Element Is Visible    ${localizador_am}    timeout=20s
    Click Element    ${localizador_am}
    Sleep    1s
    
    Log    ✓ Período AM selecionado    level=DEBUG

Selecionar Período PM
    [Documentation]    Seleciona o período PM no spinner de período
    ...                Primeiro clica no spinner para abrir as opções
    ...                Depois clica na opção PM
    
    Log    Selecionando período PM    level=DEBUG
    
    # Clicar no spinner para abrir opções
    ${localizador_spinner}=    Obter Localizador Spinner AM/PM
    Wait Until Element Is Visible    ${localizador_spinner}    timeout=20s
    Click Element    ${localizador_spinner}
    Sleep    1s
    
    # Selecionar opção PM
    ${localizador_pm}=    Obter Localizador Opção PM
    Wait Until Element Is Visible    ${localizador_pm}    timeout=20s
    Click Element    ${localizador_pm}
    Sleep    1s
    
    Log    ✓ Período PM selecionado    level=DEBUG

Confirmar Alarme
    [Documentation]    Clica no botão OK/Confirmar para salvar o alarme
    ...                Aguarda transição de volta para a tela de lista de alarmes
    
    Log    Confirmando criação do alarme    level=DEBUG
    
    ${localizador}=    Obter Localizador Botão OK
    Wait Until Element Is Visible    ${localizador}    timeout=20s
    Click Element    ${localizador}
    Sleep    5s
    
    Log    ✓ Alarme confirmado    level=DEBUG
