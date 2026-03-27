*** Settings ***
Documentation    Page Object para tela de Alarmes do aplicativo de Relógio Android
...              Centraliza TODOS os localizadores da funcionalidade de alarmes
...              Seguindo o padrão Page Object Model para facilitar manutenção
...              
...              REFERÊNCIA: docs/alarm-project/elements/Elements.md

*** Keywords ***
Obter Localizador Botão Adicionar Alarme
    [Documentation]    Retorna localizador do botão FAB de adicionar alarme
    ...                REFERÊNCIA: Elements.md - Item 3
    ...                TIPO: ImageButton com content-desc
    ...                CONTEXTO: Tela principal de alarmes
    RETURN    xpath=//android.widget.ImageButton[@content-desc="Add alarm"]

Obter Localizador Switch Input Texto
    [Documentation]    Botão para alternar para modo de entrada de texto
    ...                REFERÊNCIA: Elements.md - Item 4
    ...                TIPO: ImageButton
    ...                CONTEXTO: Tela de configuração de alarme
    RETURN    xpath=//android.widget.ImageButton[@content-desc="Switch to text input mode for the time input."]

Obter Localizador Campo Hora
    [Documentation]    Campo EditText para entrada da hora
    ...                REFERÊNCIA: Elements.md - Item 5
    ...                TIPO: EditText com resource-id android padrão
    ...                CONTEXTO: Após ativar modo de entrada de texto
    RETURN    xpath=//android.widget.EditText[@resource-id="android:id/input_hour"]

Obter Localizador Campo Minuto
    [Documentation]    Campo EditText para entrada dos minutos
    ...                REFERÊNCIA: Elements.md - Item 6
    ...                TIPO: EditText com resource-id android padrão
    ...                CONTEXTO: Após ativar modo de entrada de texto
    RETURN    xpath=//android.widget.EditText[@resource-id="android:id/input_minute"]

Obter Localizador Spinner AM/PM
    [Documentation]    Spinner de seleção do período AM/PM
    ...                REFERÊNCIA: Elements.md - Item 7
    ...                TIPO: Spinner com resource-id android padrão
    ...                IMPORTANTE: Só existe quando dispositivo está em formato de 12 horas
    ...                CONTEXTO: Tela de configuração de alarme
    RETURN    xpath=//android.widget.Spinner[@resource-id="android:id/am_pm_spinner"]

Obter Localizador Opção AM
    [Documentation]    Opção AM dentro do Spinner de período
    ...                REFERÊNCIA: Elements.md - Item 8
    ...                TIPO: CheckedTextView com texto "AM"
    ...                CONTEXTO: Após clicar no Spinner AM/PM
    RETURN    xpath=//android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="AM"]

Obter Localizador Opção PM
    [Documentation]    Opção PM dentro do Spinner de período
    ...                REFERÊNCIA: Elements.md - Item 8
    ...                TIPO: CheckedTextView com texto "PM"
    ...                CONTEXTO: Após clicar no Spinner AM/PM
    RETURN    xpath=//android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="PM"]

Obter Localizador Botão OK
    [Documentation]    Botão de confirmação/salvar alarme
    ...                REFERÊNCIA: Elements.md - Item 9
    ...                TIPO: Button com resource-id android padrão
    ...                CONTEXTO: Tela de configuração de alarme
    RETURN    xpath=//android.widget.Button[@resource-id="android:id/button1"]
