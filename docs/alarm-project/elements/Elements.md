### 3. **Elements.md (Mapeamento de Elementos do App)**
```markdown
# Mapeamento de Elementos do Aplicativo de Relógio

## Elementos do App

### 0. Verificação Inicial do Aplicativo

**⚠️ IMPORTANTE: Elemento para verificar que o app foi aberto corretamente**

Após executar `Open Application`, é **obrigatório** aguardar que um elemento da tela principal esteja visível antes de prosseguir com qualquer interação.

**Elemento Recomendado para Verificação**: **Botão FAB "Add alarm"**

- **Por que este elemento?**
  - ✅ Sempre visível na tela de Alarmes
  - ✅ Único e confiável
  - ✅ Usa `content-desc` (independente de idioma)
  - ✅ Será usado logo em seguida no teste

- **Como usar**:
  ```robotframework
  # CORRETO ✅
  Open Application    ${APPIUM_SERVER}    ...
  ${localizador_fab}=    Obter Localizador Botão Adicionar Alarme
  Wait Until Element Is Visible    ${localizador_fab}    timeout=${TIMEOUT_PADRAO}
  ```

- **O que NÃO fazer**:
  ```robotframework
  # ERRADO ❌ - Nunca use localizador vazio
  Wait Until Page Contains Element    ${EMPTY}    timeout=${TIMEOUT_PADRAO}
  ```

**XPath do Elemento**: `//android.widget.ImageButton[@content-desc="Add alarm"]`

---

### Navegação Principal
1. **Ícone do Relógio**
   - **Descrição**: Ícone para abrir o aplicativo de Relógio.
   - **XPath**: `//android.widget.TextView[@content-desc="Clock"]`

2. **Aba Alarm**
   - **Descrição**: Aba/botão para acessar a tela de Alarmes. O aplicativo de Relógio pode abrir em diferentes abas (Alarm, Timer, Stopwatch, Clock). É necessário clicar nesta aba para garantir que está na tela correta.
   - **XPath**: `//android.widget.TextView[@text="Alarm"]`
   - **Observações**: 
     - Sempre clicar nesta aba após abrir o aplicativo
     - Se já estiver na tela de Alarmes, o elemento pode não estar visível

### Tela de Alarmes
3. **Botão de Adicionar Alarme**
   - **Descrição**: Botão para criar um novo alarme.
   - **XPath**: `//android.widget.ImageButton[@content-desc="Add alarm"]`
4. **Teclado de Entrada de Hora**
   - **Descrição**: Botão para alternar para o modo de entrada de texto para o horário.
   - **XPath**: `//android.widget.ImageButton[@content-desc="Switch to text input mode for the time input."]`
5. **Campo de Entrada de Hora**
   - **Descrição**: Campo onde o usuário digita a hora do alarme.
   - **XPath**: `//android.widget.EditText[@resource-id="android:id/input_hour"]`
6. **Campo de Entrada de Minutos**
   - **Descrição**: Campo onde o usuário digita os minutos do alarme.
   - **XPath**: `//android.widget.EditText[@resource-id="android:id/input_minute"]`

7. **Spinner de Seleção AM/PM**
   - **Descrição**: Spinner para selecionar o período AM (manhã) ou PM (tarde/noite) do alarme.
   - **XPath**: `//android.widget.Spinner[@resource-id="android:id/am_pm_spinner"]`
   - **Observações**: 
     - Este elemento aparece em dispositivos configurados com formato de 12 horas
     - Em formato de 24 horas, este elemento pode não estar presente

8. **Texto do Período AM/PM Selecionado**
   - **Descrição**: CheckedTextView que exibe o período atualmente selecionado (AM ou PM).
   - **XPath**: `//android.widget.CheckedTextView[@resource-id="android:id/text1"]`
   - **Uso**: 
     - Para ler o período atual: `Get Text` no elemento
     - Para selecionar período específico: `//android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="AM"]` ou `@text="PM"`
   - **Contexto**: Elemento filho do Spinner AM/PM

9. **Botão de Confirmar**
   - **Descrição**: Botão para confirmar a criação do alarme.
   - **XPath**: `//android.widget.Button[@resource-id="android:id/button1"]`

10. **Exibição do Alarme**
   - **Descrição**: Elemento que exibe o alarme criado na lista de alarmes.
   - **Observações**: 
     - ⚠️ O formato de exibição do alarme pode variar dependendo da entrada
     - **Recomendação**: Usar hora SEM zero à esquerda na entrada (ex: "8", "6")
     - Formato padrão Android: `H:MM AM/PM` onde H é 1-12 sem zero à esquerda
     - Exemplos: "6:45 PM", "8:30 AM", "12:00 PM"
     - Se digitar "08", o alarme pode aparecer como "08:30 AM" (preserva formato)
     - Se digitar "8", o alarme aparece como "8:30 AM" (formato padrão)
   
   **⚠️ PROBLEMA COMUM: Variação de Atributos no Android**
   
   O Android pode armazenar o horário do alarme em **diferentes atributos** dependendo da versão e fabricante:
   - A maioria dos dispositivos usa `content-desc`
   - Alguns usam `text`
   - Geralmente TextView, mas pode variar
   
   **✅ SOLUÇÃO IMPLEMENTADA: Validação de Existência + Visibilidade**
   
   O localizador confirmado que funciona é:
   
   ```xpath
   //android.widget.TextView[@content-desc="${hora_formatada}"]
   ```
   
   **Estratégia**: Primeiro validar se o elemento **existe na página** (DOM), depois garantir que está **visível**.
   
   **Implementação (3 Níveis de Validação)**:
   
   1. **Validar Existência na Página**
      ```robotframework
      ${exists}=    Run Keyword And Return Status
      ...    Page Should Contain Element    ${localizador}
      ```
      - Verifica se elemento existe no DOM (mesmo que não visível)
      - Se existe, usar `Wait Until Element Is Visible` (faz scroll automático)
   
   2. **UiScrollable - Scroll Nativo**
      ```robotframework
      ${scroll_locator}=    Set Variable    android=new UiScrollable(...).scrollIntoView(...)
      Page Should Contain Element    ${scroll_locator}
      ```
      - Usa scroll nativo do Android para encontrar elemento
   
   3. **Scroll Manual - Fallback (5 tentativas)**
      ```robotframework
      FOR    ${i}    IN RANGE    5
          ${found}=    Page Should Contain Element    ${localizador}
          IF    ${found}
              Wait Until Element Is Visible    ${localizador}
              RETURN
          END
          Swipe    540    1500    540    500
          Sleep    1s
      END
      ```
   
   **Timeouts**:
   - Sleep após confirmar: 5 segundos
   - Sleep antes de verificar: 2 segundos  
   - Wait Until Visible: 10 segundos
   - Scroll manual: 5 tentativas × 1s = 5 segundos
   - **Total máximo**: ~22 segundos
   
   **📸 DIAGNÓSTICO: Como Investigar Se Alarme Não For Encontrado**
   
   Se os testes falharem com "alarme não encontrado", siga estes passos:
   
   **1. Verifique o Screenshot Capturado**
   - Após a falha, um screenshot é automaticamente capturado
   - Localize o arquivo `selenium-screenshot-*.png` na raiz do projeto
   - Verifique se o alarme realmente foi criado e está visível na tela
   
   **2. Identifique o Formato Real do Alarme**
   - Possíveis variações de formato:
     - `8:30 AM` (formato padrão inglês, sem zero à esquerda) ✅ CORRETO
     - `08:30 AM` (formato com zero à esquerda)
     - `8:30` (formato 12h sem AM/PM - improvável)
     - `08:30` (formato 24h - significa que dispositivo não está em 12h)
   
   **3. Verifique a Configuração do Dispositivo**
   ```
   Configurações → Sistema → Data e hora → Usar formato de 24 horas
   ❌ Deve estar DESATIVADO (usar formato de 12 horas)
   ```
   
   **4. Use Appium Inspector para Inspecionar Elementos**
   
   **Instalar Appium Inspector:**
   ```bash
   # Download de: https://github.com/appium/appium-inspector/releases
   # Ou via npm:
   npm install -g appium-inspector
   ```
   
   **Configurar Capabilities no Inspector:**
   ```json
   {
     "platformName": "Android",
     "automationName": "UiAutomator2",
     "appPackage": "com.google.android.deskclock",
     "appActivity": "com.android.deskclock.DeskClock",
     "noReset": false,
     "fullReset": false
   }
   ```
   
   **⚠️ IMPORTANTE**: Use `"noReset": false` para garantir que o app abra corretamente.
   
   **Passos para Inspecionar:**
   1. Crie um alarme manualmente no dispositivo (ex: 8:30 AM)
   2. Abra o Appium Inspector
   3. Conecte ao servidor Appium (http://localhost:4723)
   4. Clique em "Start Session"
   5. Localize o alarme na hierarquia de elementos
   6. Verifique:
      - Tipo do elemento (`android.widget.TextView`, `LinearLayout`, etc)
      - Valor no atributo `text`
      - Valor no atributo `content-desc`
      - Valor no atributo `resource-id`
   
   **5. Atualize os Localizadores Conforme Necessário**
   
   Se descobrir que o formato é diferente, atualize em `alarm_page.robot`:
   
   ```robotframework
   # Exemplo: se o formato for "08:30 AM" (com zero à esquerda)
   # Adicione à lista de localizadores:
   Obter Localizadores Alarme
       [Arguments]    ${hora_formatada}
       
       # Converte "8:30 AM" para "08:30 AM" se necessário
       ${hora_com_zero}=    # Lógica de formatação
       
       @{localizadores}=    Create List
       ...    xpath=//android.widget.TextView[@text="${hora_formatada}"]
       ...    xpath=//android.widget.TextView[@text="${hora_com_zero}"]
       ...    # ... outros localizadores
   ```
   
   **6. Verifique o Idioma do Dispositivo**
   
   Se o dispositivo estiver em português, AM/PM pode aparecer como:
   - "AM" / "PM" (mantém em inglês - mais comum)
   - Ou pode não aparecer se estiver em formato 24h
   
   **7. Solução Alternativa: Desabilitar Validação Temporariamente**
   
   Para testar se o problema está apenas na validação:
   
   ```robotframework
   # Comente temporariamente a validação em test_alarm.robot
   Então o alarme ${hora}:${minuto} ${periodo} deve aparecer na lista
       Log    Validação desabilitada temporariamente - apenas para debug
       # Validar Alarme Criado    ${hora_formatada}
   ```
   
   **Exemplo de Keyword com Fallback:**
   ```robotframework
   Tentar Localizar Alarme
       [Arguments]    ${hora_formatada}
       FOR    ${localizador}    IN    @{lista_de_localizadores}
           ${status}=    Run Keyword And Ignore Error
           ...    Wait Until Element Is Visible    ${localizador}    timeout=3s
           Return From Keyword If    '${status}' == 'PASS'    ${True}
       END
       [Return]    ${False}
   ```
   
   **Por que isso acontece:**
   - Diferentes versões do Android usam atributos diferentes
   - Fabricantes customizam o app de Relógio (Samsung, Xiaomi, etc)
   - Alguns dispositivos usam `content-desc` para acessibilidade
   - Outros usam apenas `text` para exibição visual
   - A hierarquia de elementos pode variar entre dispositivos
