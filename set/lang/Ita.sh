#!/bin/bash
# language: Italian
# Version: 1.0.0
# License: MIT
# Copyright (c) 2025 rokhanz

LANG_NAME="Italiano"
LANG_EMOJI="🇮🇹"

# Menu principale & globale
LANG_MENU_INSTALL=" Installa XRDP + ambiente desktop"
LANG_MENU_UNINSTALL="❌ Disinstalla XRDP & ambiente desktop"
LANG_MENU_TOOLS="️ Installa applicazioni/strumenti XRDP"
LANG_MENU_INFO="ℹ️ Informazioni & Stato"
LANG_EXT_MENU_TITLE="🧩Procedura guidata estensioni VSCode"
LANG_MENU_SET=" Impostazioni/SET"
LANG_MENU_EXIT=" Esci"
LANG_MENU_PROMPT="Seleziona menu (1/2/3/4/5/6):"
LANG_INVALID_OPTION="❌ Opzione non valida!"
LANG_SUCCESS_INSTALL="✅ Installazione completata!"
LANG_SUCCESS_UNINSTALL="✅ Disinstallazione completata!"
LANG_GOODBYE=" A presto!"
LANG_WARN_ALREADY_INSTALLED="⚠️ Già configurato."
LANG_BACK_TO_MAIN_MENU="↩️ Torna al menu principale"
LANG_BACK_MAIN="↩️ Torna al menu principale tra 10 secondi... (premi Invio per tornare subito)"

# Aggiungi nuovo utente
LANG_ADD_XRDP_USER_TITLE="=== 👤 Aggiungi utente XRDP ==="
LANG_ADD_XRDP_USER_PROMPT="Inserisci nuovo nome utente: "
LANG_ADD_XRDP_USER_EXISTS="⚠️  Utente già esistente."
LANG_ADD_XRDP_USER_SUCCESS="✅ Utente creato con successo."
LANG_ADD_XRDP_USER_FAIL="❌ Creazione utente non riuscita."
LANG_ADD_XRDP_USER_PASS_PROMPT="Inserisci password: "
LANG_ADD_XRDP_USER_PASS_SET="✅ Password impostata."
LANG_ADD_XRDP_USER_PASS_FAIL="❌ Impostazione password non riuscita."
LANG_ADD_XRDP_USER_SUDO_PROMPT="Aggiungere l’utente al gruppo sudo? (y/n): "
LANG_ADD_XRDP_USER_SUDO_OK="✅ Utente aggiunto al gruppo sudo."
LANG_ADD_MENU_XRDP="➕ Aggiungi nuovo utente"

# Menu strumenti
LANG_TOOLS_MENU_TITLE=" Installa applicazioni/strumenti XRDP"
LANG_TOOLS_INSTALL_ALL="Installa tutti gli strumenti"
LANG_TOOLS_MENU_PROMPT="Seleziona menu strumenti (1/2/3/4):"

# Menu impostazioni
LANG_SET_MENU_TITLE=" Impostazioni/SET XRDP & Strumenti"
LANG_SET_DESKTOP_LANG=" Imposta lingua desktop (GUI XRDP)"
LANG_SET_TERMINAL_LANG="️ Imposta lingua terminale/script"
LANG_SET_PORT=" Imposta porta XRDP"
LANG_SET_TIMEZONE=" Imposta fuso orario"
LANG_SET_VPS_INFO=" Imposta/Reset informazioni VPS (Conky)"
LANG_SET_SUCCESS="✅ Impostazioni applicate con successo!"
LANG_SET_FAIL="❌ Impostazioni non riuscite!"
LANG_BACK_TO_TOOLS="↩️ Torna al menu strumenti"

# Informazioni & Stato
LANG_INFO_TITLE="ℹ️ Informazioni & Stato VPS XRDP"
LANG_TIPS_STATUS=" Suggerimento: usa il menu SET per impostazioni avanzate."
LANG_ALREADY_INSTALLED="✅ già installato"
LANG_ALREADY_UNINSTALLED="❌ già disinstallato!"
LANG_STEP_DONE="✅ Fatto"
LANG_FAIL_EMOJI="❌ Fallito!"
LANG_SUCCESS_EMOJI="✅"
LANG_WARN_EMOJI="⚠️"

# Testi batch
LANG_BATCH_ALREADY_INSTALLED="⚠️ Batch già installato!"
LANG_BATCH_ALREADY_CONFIGURED="⚠️ Batch SET già eseguito!"
LANG_BATCH_SUCCESS="✅ Tutte le installazioni batch riuscite!"
LANG_BATCH_FAIL="❌ Errore nell'installazione batch!"
LANG_BATCH_UNINSTALL_SUCCESS="✅ Tutte le disinstallazioni batch riuscite!"
LANG_BATCH_UNINSTALL_FAIL="❌ Errore nella disinstallazione batch!"
LANG_BATCH_SET_SUCCESS="✅ Tutte le configurazioni batch completate!"
LANG_BATCH_INSTALL_TITLE=" Installa Batch XRDP + Desktop + Strumenti"
LANG_BATCH_UNINSTALL_TITLE="❌ Disinstalla Batch XRDP + Desktop + Strumenti"
LANG_BATCH_SET_TITLE=" Configurazione Batch XRDP & Strumenti"

# Testi fasi
LANG_STEP_DEPS="Installa dipendenze di base"
LANG_STEP_DESKTOP="Installa ambiente desktop"
LANG_STEP_XRDP="Installa core XRDP"
LANG_STEP_CHROME="Installa Google Chrome"
LANG_STEP_VLC="Installa VLC"
LANG_STEP_VSCODE="Installa VSCode"
LANG_STEP_CONFIG="Configurazione aggiuntiva"
LANG_STEP_UN_XRDP="Disinstalla core XRDP"
LANG_STEP_UN_DESKTOP="Disinstalla ambiente desktop"
LANG_STEP_UN_CHROME="Disinstalla Google Chrome"
LANG_STEP_UN_VLC="Disinstalla VLC"
LANG_STEP_UN_VSCODE="Disinstalla VSCode"
LANG_STEP_UN_CONKY="Disinstalla Conky/Config"

# Procedura guidata estensioni
LANG_EXT_MENU_TITLE=" Procedura guidata estensioni VSCode"
LANG_EXT_DEFAULT="1. Predefinito: installa estensioni consigliate (automatico)"
LANG_EXT_CUSTOM="2. Personalizzato: seleziona estensioni per categoria"
LANG_EXT_CATEGORY_PROMPT="Seleziona categoria estensioni da installare:"
LANG_EXT_CHOOSE_PROMPT="Digita il numero categoria (separati da spazi):"
LANG_EXT_LIST_PROMPT="Seleziona estensioni da questa categoria:"
LANG_EXT_CHOOSE_EXT_PROMPT="Digita i numeri delle estensioni (separati da spazi):"
LANG_EXT_SAVE="11. Salva & Installa"
LANG_EXT_BACK="0. Indietro"
LANG_EXT_CHOSEN="Hai selezionato le estensioni:"
LANG_EXT_INSTALL="Installo estensione..."
LANG_EXT_DONE="✅ Tutte le estensioni installate!"
LANG_EXT_ERR_EMPTY="Nessuna estensione selezionata."
LANG_EXT_ERR_NO_EXT="Nessun file estensione da disinstallare!"
LANG_EXT_ERR_NOT_FOUND="File estensione non trovato!"

# Disinstalla VSCode
LANG_UNINSTALL_VSCODE_EXTENSIONS="️ Rimuovo estensioni VSCode..."
LANG_UNINSTALL_VSCODE_APP="️ Rimuovo applicazione VSCode..."
LANG_UNINSTALL_VSCODE_ALL="️ Rimuovo applicazione & tutte le estensioni VSCode..."

# Errori generali
LANG_ERROR_MARKER="❌ Impossibile creare marker!"
LANG_LOGGING_ERROR="❌ Impossibile registrare log errori!"
