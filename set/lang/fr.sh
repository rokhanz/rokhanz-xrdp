#!/bin/bash
# language: French
# Version: 1.0.0
# License: MIT
# Copyright (c) 2025 rokhanz

LANG_NAME="France"
LANG_EMOJI="🇫🇷"

# Menu principal & global
LANG_MENU_INSTALL=" Installer XRDP + environnement de bureau"
LANG_MENU_UNINSTALL="❌ Désinstaller XRDP et environnement de bureau"
LANG_MENU_TOOLS="️ Installer applications/outils XRDP"
LANG_EXT_MENU_TITLE="🧩Assistant d’extensions VSCode"
LANG_MENU_INFO="ℹ️ Infos & statut"
LANG_MENU_SET=" Paramètres/SET"
LANG_MENU_EXIT=" Quitter"
LANG_MENU_PROMPT="Sélectionnez le menu (1/2/3/4/5/6):"
LANG_INVALID_OPTION="❌ Option invalide !"
LANG_SUCCESS_INSTALL="✅ Installation terminée !"
LANG_SUCCESS_UNINSTALL="✅ Désinstallation terminée !"
LANG_GOODBYE=" À bientôt !"
LANG_WARN_ALREADY_INSTALLED="⚠️ Déjà configuré."
LANG_BACK_TO_MAIN_MENU="↩️ Retour au menu principal"
LANG_BACK_MAIN="↩️ Retour au menu principal dans 10 secondes... (appuyez sur Entrée pour revenir immédiatement)"

# Préfixes de journalisation & emoji
LANG_OK_EMOJI="✅"
LANG_WARN_EMOJI="⚠️"
LANG_ERROR_EMOJI="❌"
LANG_LOG_OK_PREFIX="[SUCCÈS]"
LANG_LOG_WARN_PREFIX="[AVERTISSEMENT]"
LANG_LOG_ERROR_PREFIX="[ERREUR]"

# Messages courants
LANG_ALREADY_DONE="Déjà fait, ignore."
LANG_STEP_DONE="Terminé."
LANG_PAUSE_PROMPT="Appuyez sur Entrée pour continuer…"

# Menu
LANG_MENU_STATUS="Statut installation & désinstallation"
LANG_MENU_EXTENSION="installer & retirer les extensions"
LANG_BATCH_DONE="Batch terminé"

# Ajouter un nouvel utilisateur
LANG_ADD_XRDP_USER_TITLE="=== 👤 Ajouter un utilisateur XRDP ==="
LANG_ADD_XRDP_USER_PROMPT="Entrez un nouveau nom d’utilisateur : "
LANG_ADD_XRDP_USER_EXISTS="⚠️  L’utilisateur existe déjà."
LANG_ADD_XRDP_USER_SUCCESS="✅ Utilisateur créé avec succès."
LANG_ADD_XRDP_USER_FAIL="❌ Échec de la création de l’utilisateur."
LANG_ADD_XRDP_USER_PASS_PROMPT="Entrez le mot de passe : "
LANG_ADD_XRDP_USER_PASS_SET="✅ Mot de passe défini."
LANG_ADD_XRDP_USER_PASS_FAIL="❌ Échec de la définition du mot de passe."
LANG_ADD_XRDP_USER_SUDO_PROMPT="Ajouter l’utilisateur au groupe sudo ? (y/n) : "
LANG_ADD_XRDP_USER_SUDO_OK="✅ Utilisateur ajouté au groupe sudo."
LANG_ADD_MENU_XRDP="➕ Ajouter un nouvel utilisateur"

# Menu outils
LANG_TOOLS_MENU_TITLE=" Installer applications/outils XRDP"
LANG_TOOLS_INSTALL_ALL="Installer tous les outils"
LANG_TOOLS_MENU_PROMPT="Sélectionnez le menu outils (1/2/3/4):"

# Menu Paramètres
LANG_SET_MENU_TITLE=" Paramètres/SET XRDP & outils"
LANG_SET_DESKTOP_LANG=" Définir la langue du bureau (interface XRDP)"
LANG_SET_TERMINAL_LANG=" Définir la langue du terminal/script"
LANG_SET_PORT=" Définir le port XRDP"
LANG_SET_TIMEZONE=" Définir le fuseau horaire"
LANG_SET_VPS_INFO=" Définir/Réinitialiser les infos VPS (Conky)"
LANG_SET_SUCCESS="✅ Paramètres appliqués avec succès !"
LANG_SET_FAIL="❌ Échec des paramètres !"
LANG_BACK_TO_TOOLS="↩️ Retour au menu outils"

# Infos & statut
LANG_INFO_TITLE="ℹ️ Infos & statut du VPS XRDP"
LANG_TIPS_STATUS=" Astuce : utilisez le menu SET pour les réglages avancés."
LANG_ALREADY_INSTALLED="✅ déjà installé"
LANG_ALREADY_UNINSTALLED="❌ déjà supprimé !"
LANG_STEP_DONE="✅ Terminé"
LANG_FAIL_EMOJI="❌ Échec !"
LANG_SUCCESS_EMOJI="✅"
LANG_WARN_EMOJI="⚠️"

# Libellés par lot
LANG_BATCH_ALREADY_INSTALLED="⚠️ Batch déjà installé !"
LANG_BATCH_ALREADY_CONFIGURED="⚠️ Batch SET déjà exécuté !"
LANG_BATCH_SUCCESS="✅ Tous les processus d’installation batch ont réussi !"
LANG_BATCH_FAIL="❌ Une erreur est survenue lors de l’installation batch !"
LANG_BATCH_UNINSTALL_SUCCESS="✅ Tous les processus de désinstallation batch ont réussi !"
LANG_BATCH_UNINSTALL_FAIL="❌ Une erreur est survenue lors de la désinstallation batch !"
LANG_BATCH_SET_SUCCESS="✅ Toutes les configurations batch sont terminées !"
LANG_BATCH_INSTALL_TITLE=" Installer batch XRDP + bureau + outils"
LANG_BATCH_UNINSTALL_TITLE="❌ Désinstaller batch XRDP + bureau + outils"
LANG_BATCH_SET_TITLE=" Configuration batch XRDP & outils"

# Libellés d’étape
LANG_STEP_DEPS="Installation des dépendances de base"
LANG_STEP_DESKTOP="Installation de l’environnement de bureau"
LANG_STEP_XRDP="Installation du cœur XRDP"
LANG_STEP_CHROME="Installation de Google Chrome"
LANG_STEP_VLC="Installation de VLC"
LANG_STEP_VSCODE="Installation de VSCode"
LANG_STEP_CONFIG="Configuration supplémentaire"
LANG_STEP_UN_XRDP="Désinstallation du cœur XRDP"
LANG_STEP_UN_DESKTOP="Désinstallation de l’environnement de bureau"
LANG_STEP_UN_CHROME="Désinstallation de Google Chrome"
LANG_STEP_UN_VLC="Désinstallation de VLC"
LANG_STEP_UN_VSCODE="Désinstallation de VSCode"
LANG_STEP_UN_CONKY="Désinstallation de Conky/config"

# Assistant extension
LANG_EXT_MENU_TITLE=" Assistant d’extensions VSCode"
LANG_EXT_DEFAULT="1. Par défaut : installer les extensions recommandées (automatique)"
LANG_EXT_CUSTOM="2. Personnalisé : choisir les extensions par catégorie"
LANG_EXT_CATEGORY_PROMPT="Sélectionnez la catégorie d’extensions à installer :"
LANG_EXT_CHOOSE_PROMPT="Tapez le numéro de la catégorie (séparés par des espaces) :"
LANG_EXT_LIST_PROMPT="Sélectionnez les extensions à installer dans cette catégorie :"
LANG_EXT_CHOOSE_EXT_PROMPT="Tapez les numéros des extensions (séparés par des espaces) :"
LANG_EXT_SAVE="11. Enregistrer & installer"
LANG_EXT_BACK="0. Retour"
LANG_EXT_CHOSEN="Vous avez choisi les extensions :"
LANG_EXT_INSTALL="Installation de l’extension…"
LANG_EXT_DONE="✅ Toutes les extensions ont été installées !"
LANG_EXT_ERR_EMPTY="Aucune extension sélectionnée."
LANG_EXT_ERR_NO_EXT="Aucun fichier d’extension à désinstaller !"
LANG_EXT_ERR_NOT_FOUND="Fichier d’extension non trouvé !"

# Désinstallation VSCode
LANG_UNINSTALL_VSCODE_EXTENSIONS="️ Suppression des extensions VSCode…"
LANG_UNINSTALL_VSCODE_APP="️ Suppression de l’application VSCode…"
LANG_UNINSTALL_VSCODE_ALL="️ Suppression de l’application & toutes les extensions VSCode…"

# Erreurs générales
LANG_ERROR_MARKER="❌ Échec de la création du marqueur !"
LANG_LOGGING_ERROR="❌ Échec de l’enregistrement du journal d’erreurs !"
