# POC-IA-ROBOT

Projeto de automação de testes para aplicativo Android de Relógio usando **Robot Framework + Appium**.

## 📋 Sobre o Projeto

POC que implementa testes automatizados para criação de alarmes no app de Relógio Android com validação de período AM/PM em formato de 12 horas.

**Metodologia**: BDD (Gherkin) + Page Object Model + Keyword Layering

**Stack**: Robot Framework 7.0.1 | Appium 2.x | Python 3.8+ | UiAutomator2

## 🎬 Demonstração

### Vídeo da Automação em Ação

![Demonstração da Automação](docs/.img/amostra.gif)

### Modelo de Arquitetura
![Modelo de Arquitetura](docs/.img/modelo.png)

## 🏗️ Estrutura

```
POC-IA-ROBOT/
├── tests/test_alarm.robot           # Casos de teste BDD
├── resources/
│   ├── keywords/alarm_keywords.robot # Keywords de negócio
│   └── pages/alarm_page.robot        # Locators (Page Objects)
├── docs/alarm-project/               # Documentação completa
│   ├── prd/PRD.md
│   ├── ssd/SDD.md
│   └── elements/Elements.md
└── requirements.txt
```

## 🚀 Quick Start

### Pré-requisitos

- **Node.js** 14+ com Appium 2.x instalado globalmente
- **Python** 3.8+ com ambiente virtual
- **Android SDK** com ADB no PATH
- **Dispositivo Android** (físico/emulador) API 28+ em formato de 12 horas

### Instalação

```bash
# 1. Clonar e navegar
git clone <url-do-repositorio>
cd POC-IA-ROBOT

# 2. Criar ambiente virtual Python
python -m venv .venv
source .venv/Scripts/activate  # Windows Git Bash
# .venv\Scripts\activate.bat   # Windows CMD

# 3. Instalar dependências
pip install -r requirements.txt
cd appium && npm install && cd ..

# 4. Configurar dispositivo
adb devices  # Verificar conexão
adb shell settings put system time_12_24 12  # Formato 12h
```

### Executar Testes

```bash
# 1. Iniciar Appium (terminal separado)
appium

# 2. Executar testes (outro terminal, com venv ativo)
robot tests/test_alarm.robot

# 3. Ver resultados
start report.html  # Windows
```

**Comandos adicionais**:
```bash
robot --include am tests/test_alarm.robot      # Apenas teste AM
robot --include pm tests/test_alarm.robot      # Apenas teste PM
robot --loglevel DEBUG tests/test_alarm.robot  # Log detalhado
```

## ⚠️ Troubleshooting

| Problema | Solução |
|----------|---------|
| **Element not found** | `adb shell settings put system time_12_24 12` |
| **Connection refused** | Iniciar Appium: `appium` |
| **No devices** | `adb devices` e aceitar USB debugging no dispositivo |
| **App não abre** | Validação robusta já implementada com 3 fallbacks |
| **Timeout** | Timeouts já configurados em 20s |

**Diagnóstico avançado**:
```bash
adb shell pm list packages | grep clock
adb shell am start -n com.google.android.deskclock/com.android.deskclock.DeskClock
appium driver list
```

## 📚 Documentação

Documentação completa em [`docs/alarm-project/`](docs/alarm-project/):

- **[PRD.md](docs/alarm-project/prd/PRD.md)** - Requisitos e casos de teste
- **[SDD.md](docs/alarm-project/ssd/SDD.md)** - Design técnico e arquitetura
- **[Elements.md](docs/alarm-project/elements/Elements.md)** - Mapeamento de elementos UI
- **[Test-Rules.md](docs/alarm-project/test-knowledge/Test-Rules.md)** - Regras e convenções

## 🛠️ Comandos Úteis

```bash
# Appium
appium --log-level debug

# ADB
adb devices
adb shell settings get system time_12_24
adb logcat

# Robot Framework
robot --include smoke tests/
robot --outputdir results tests/
```

## 📄 Licença

Projeto de demonstração e fins educacionais.

---

**Versão**: 1.0.0 | **Robot Framework**: 7.0.1 | **Appium**: 2.x
