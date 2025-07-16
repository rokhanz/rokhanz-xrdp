#!/bin/bash
# language: German
# Version: 1.0.0
# License: MIT
# Copyright (c) 2025 rokhanz

LANG_NAME="Deutsch"
LANG_EMOJI="🇩🇪"

# Hauptmenü & global
LANG_MENU_INSTALL=" Installiere XRDP + Desktop-Umgebung"
LANG_MENU_UNINSTALL="❌ Deinstalliere XRDP & Desktop-Umgebung"
LANG_MENU_TOOLS="️ Installiere XRDP Anwendungen/Tools"
LANG_EXT_MENU_TITLE="🧩VSCode Erweiterungs-Assistent"
LANG_MENU_INFO="ℹ️ Info & Status"
LANG_MENU_SET=" Einstellungen/SET"
LANG_MENU_EXIT=" Beenden"
LANG_MENU_PROMPT="Wähle Menü (1/2/3/4/5/6):"
LANG_INVALID_OPTION="❌ Ungültige Option!"
LANG_SUCCESS_INSTALL="✅ Installation abgeschlossen!"
LANG_SUCCESS_UNINSTALL="✅ Deinstallation abgeschlossen!"
LANG_GOODBYE=" Bis zum nächsten Mal!"
LANG_WARN_ALREADY_INSTALLED="⚠️ Bereits eingerichtet."
LANG_BACK_TO_MAIN_MENU="↩️ Zurück zum Hauptmenü"
LANG_BACK_MAIN="↩️ Zurück zum Hauptmenü in 10 Sekunden... (Drücke Enter für sofortige Rückkehr)"

# Neuen Benutzer hinzufügen
LANG_ADD_XRDP_USER_TITLE="=== 👤 XRDP-Benutzer hinzufügen ==="
LANG_ADD_XRDP_USER_PROMPT="Neuen Benutzernamen eingeben: "
LANG_ADD_XRDP_USER_EXISTS="⚠️  Benutzer existiert bereits."
LANG_ADD_XRDP_USER_SUCCESS="✅ Benutzer erfolgreich erstellt."
LANG_ADD_XRDP_USER_FAIL="❌ Benutzererstellung fehlgeschlagen."
LANG_ADD_XRDP_USER_PASS_PROMPT="Passwort eingeben: "
LANG_ADD_XRDP_USER_PASS_SET="✅ Passwort gesetzt."
LANG_ADD_XRDP_USER_PASS_FAIL="❌ Passwort konnte nicht gesetzt werden."
LANG_ADD_XRDP_USER_SUDO_PROMPT="Benutzer zur sudo-Gruppe hinzufügen? (y/n): "
LANG_ADD_XRDP_USER_SUDO_OK="✅ Benutzer zur sudo-Gruppe hinzugefügt."
LANG_ADD_MENU_XRDP="➕ Neuen Benutzer hinzufügen"

# Tools Menü
LANG_TOOLS_MENU_TITLE=" Installiere XRDP Anwendungen/Tools"
LANG_TOOLS_INSTALL_ALL="Alle Tools installieren"
LANG_TOOLS_MENU_PROMPT="Wähle Tools Menü (1/2/3/4):"

# Einstellungen Menü
LANG_SET_MENU_TITLE=" Einstellungen/SET XRDP & Tools"
LANG_SET_DESKTOP_LANG=" Desktop-Sprache einstellen (XRDP GUI)"
LANG_SET_TERMINAL_LANG="️ Terminal/Skript-Sprache einstellen"
LANG_SET_PORT=" XRDP Port einstellen"
LANG_SET_TIMEZONE=" Zeitzone einstellen"
LANG_SET_VPS_INFO=" VPS Informationen einstellen/zurücksetzen (Conky)"
LANG_SET_SUCCESS="✅ Einstellungen erfolgreich!"
LANG_SET_FAIL="❌ Einstellungen fehlgeschlagen!"
LANG_BACK_TO_TOOLS="↩️ Zurück zum Tools Menü"

# Info & Status
LANG_INFO_TITLE="ℹ️ XRDP VPS Info & Status"
LANG_TIPS_STATUS=" Tipp: Nutze das SET Menü für erweiterte Einstellungen."
LANG_ALREADY_INSTALLED="✅ bereits installiert"
LANG_ALREADY_UNINSTALLED="❌ bereits deinstalliert!"
LANG_STEP_DONE="✅ Fertig"
LANG_FAIL_EMOJI="❌ Fehlgeschlagen!"
LANG_SUCCESS_EMOJI="✅"
LANG_WARN_EMOJI="⚠️"

# Batch Formulierungen
LANG_BATCH_ALREADY_INSTALLED="⚠️ Batch wurde bereits installiert!"
LANG_BATCH_ALREADY_CONFIGURED="⚠️ Batch SET wurde bereits ausgeführt!"
LANG_BATCH_SUCCESS="✅ Alle Batch-Installationen erfolgreich!"
LANG_BATCH_FAIL="❌ Fehler bei der Batch-Installation!"
LANG_BATCH_UNINSTALL_SUCCESS="✅ Alle Batch-Deinstallationen erfolgreich!"
LANG_BATCH_UNINSTALL_FAIL="❌ Fehler bei der Batch-Deinstallation!"
LANG_BATCH_SET_SUCCESS="✅ Alle Batch-Konfigurationen abgeschlossen!"
LANG_BATCH_INSTALL_TITLE=" Installiere Batch XRDP + Desktop + Tools"
LANG_BATCH_UNINSTALL_TITLE="❌ Deinstalliere Batch XRDP + Desktop + Tools"
LANG_BATCH_SET_TITLE=" Batch XRDP & Tools Konfiguration"

# Schritt Formulierungen
LANG_STEP_DEPS="Installiere Basis-Abhängigkeiten"
LANG_STEP_DESKTOP="Installiere Desktop-Umgebung"
LANG_STEP_XRDP="Installiere XRDP Kern"
LANG_STEP_CHROME="Installiere Google Chrome"
LANG_STEP_VLC="Installiere VLC"
LANG_STEP_VSCODE="Installiere VSCode"
LANG_STEP_CONFIG="Zusätzliche Konfiguration"
LANG_STEP_UN_XRDP="Deinstalliere XRDP Kern"
LANG_STEP_UN_DESKTOP="Deinstalliere Desktop-Umgebung"
LANG_STEP_UN_CHROME="Deinstalliere Google Chrome"
LANG_STEP_UN_VLC="Deinstalliere VLC"
LANG_STEP_UN_VSCODE="Deinstalliere VSCode"
LANG_STEP_UN_CONKY="Deinstalliere Conky/Konfig"

# Erweiterungs-Assistent
LANG_EXT_MENU_TITLE=" VSCode Erweiterungs-Assistent"
LANG_EXT_DEFAULT="1. Standard: Empfohlene Erweiterungen installieren (automatisch)"
LANG_EXT_CUSTOM="2. Benutzerdefiniert: Erweiterungen nach Kategorie wählen"
LANG_EXT_CATEGORY_PROMPT="Wähle Kategorie der Erweiterungen:"
LANG_EXT_CHOOSE_PROMPT="Nummer der Kategorie eingeben (mit Leerzeichen trennen):"
LANG_EXT_LIST_PROMPT="Wähle Erweiterungen aus dieser Kategorie:"
LANG_EXT_CHOOSE_EXT_PROMPT="Nummer der Erweiterung eingeben (mit Leerzeichen trennen):"
LANG_EXT_SAVE="11. Speichern & Installieren"
LANG_EXT_BACK="0. Zurück"
LANG_EXT_CHOSEN="Ausgewählte Erweiterungen:"
LANG_EXT_INSTALL="Installiere Erweiterung..."
LANG_EXT_DONE="✅ Alle Erweiterungen installiert!"
LANG_EXT_ERR_EMPTY="Keine Erweiterungen ausgewählt."
LANG_EXT_ERR_NO_EXT="Keine Erweiterungsdateien zum Deinstallieren!"
LANG_EXT_ERR_NOT_FOUND="Erweiterungsdatei nicht gefunden!"

# VSCode Deinstallation
LANG_UNINSTALL_VSCODE_EXTENSIONS="️ Entferne VSCode Erweiterungen..."
LANG_UNINSTALL_VSCODE_APP="️ Entferne VSCode Anwendung..."
LANG_UNINSTALL_VSCODE_ALL="️ Entferne Anwendung & alle VSCode Erweiterungen..."

# Allgemeine Fehler
LANG_ERROR_MARKER="❌ Markierung konnte nicht erstellt werden!"
LANG_LOGGING_ERROR="❌ Fehlerprotokoll konnte nicht geschrieben werden!"
