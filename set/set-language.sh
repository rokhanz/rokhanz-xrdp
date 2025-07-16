#!/bin/bash
# set-language.sh - Multi-language support untuk seluruh script XRDP
# Author: rokhanz
# Version: 1.0.0
# License: MIT

LANG_SET=${LANG_SET:-"id"}  # export LANG_SET="en" untuk English

# =======================
# Bahasa Indonesia (id)
# =======================
if [ "$LANG_SET" = "id" ]; then
  # --- Menu utama & global
  LANG_MENU_INSTALL="🚀 Install XRDP + Desktop Environment"
  LANG_MENU_UNINSTALL="❌ Uninstall XRDP & Desktop Environment"
  LANG_MENU_TOOLS="🛠️  Install aplikasi/tools XRDP"
  LANG_MENU_INFO="ℹ️  Info & Status"
  LANG_MENU_SET="🔧 Pengaturan/SET"
  LANG_MENU_EXIT="🚪 Keluar"
  LANG_MENU_PROMPT="Pilih menu (1/2/3/4/5/6):"
  LANG_INVALID_OPTION="❌ Pilihan tidak valid!"
  LANG_SUCCESS_INSTALL="✅ Instalasi selesai!"
  LANG_SUCCESS_UNINSTALL="✅ Uninstall selesai!"
  LANG_GOODBYE="👋 Sampai jumpa!"
  LANG_WARN_ALREADY_INSTALLED="⚠️  Sudah diatur sebelumnya."
  LANG_BACK_TO_MAIN_MENU="↩️  Kembali ke menu utama"
  LANG_BACK_MAIN="↩️  Kembali ke menu utama dalam 10 detik... (tekan Enter untuk langsung kembali)"

  # --- Tools menu
  LANG_TOOLS_MENU_TITLE="📦 Install Aplikasi/Tools XRDP"
  LANG_TOOLS_INSTALL_ALL="Install Semua Tools"
  LANG_TOOLS_MENU_PROMPT="Pilih menu tools (1/2/3/4):"

  # --- Set menu
  LANG_SET_MENU_TITLE="🔧 Pengaturan/SET XRDP & Tools"
  LANG_SET_DESKTOP_LANG="🌐 Set Bahasa Desktop (XRDP GUI)"
  LANG_SET_TERMINAL_LANG="🗣️  Set Bahasa Terminal/Script"
  LANG_SET_PORT="🔢 Set XRDP Port"
  LANG_SET_TIMEZONE="🌏 Set Zona Waktu (Timezone)"
  LANG_SET_VPS_INFO="📊 Set/Reset Info VPS (Conky)"
  LANG_SET_SUCCESS="✅ Pengaturan berhasil!"
  LANG_SET_FAIL="❌ Pengaturan gagal!"
  LANG_BACK_TO_TOOLS="↩️  Kembali ke menu tools"
  LANG_STEP_SET_LANG_TERM="Set Bahasa Terminal"
  LANG_STEP_SET_LANG_GUI="Set Bahasa Desktop (GUI)"
  LANG_STEP_SET_PORT="Set Port XRDP"
  LANG_STEP_SET_TZ="Set Zona Waktu"
  LANG_STEP_SET_CONKY="Set Info VPS/Conky"

  # --- Info, Status & Tips
  LANG_INFO_TITLE="ℹ️  Info & Status VPS XRDP"
  LANG_TIPS_STATUS="💡 Tips: Gunakan menu SET untuk pengaturan lanjutan."
  LANG_ALREADY_INSTALLED="✅ sudah terpasang"
  LANG_ALREADY_UNINSTALLED="❌ sudah dihapus!"
  LANG_STEP_DONE="✅ Selesai"
  LANG_FAIL_EMOJI="❌ Gagal!"
  LANG_SUCCESS_EMOJI="✅"
  LANG_WARN_EMOJI="⚠️"
  LANG_UNINSTALL_ALL_TITLE="❌ Uninstall XRDP & Semua Komponen"
  LANG_UNINSTALL_DONE="✅ Uninstall selesai!"
  LANG_BATCH_ALREADY_INSTALLED="⚠️  Batch sudah pernah diinstall!"
  LANG_BATCH_ALREADY_CONFIGURED="⚠️  Batch SET sudah pernah dijalankan!"
  LANG_BATCH_SUCCESS="✅ Semua proses install batch sukses!"
  LANG_BATCH_FAIL="❌ Ada error pada instalasi batch!"
  LANG_BATCH_UNINSTALL_SUCCESS="✅ Semua uninstall batch sukses!"
  LANG_BATCH_UNINSTALL_FAIL="❌ Ada error pada uninstall batch!"
  LANG_BATCH_SET_SUCCESS="✅ Semua batch konfigurasi selesai!"

  # --- Batch wording
  LANG_BATCH_INSTALL_TITLE="🚀 Install Batch XRDP + Desktop + Tools"
  LANG_BATCH_UNINSTALL_TITLE="❌ Uninstall Batch XRDP + Desktop + Tools"
  LANG_BATCH_SET_TITLE="🔧 Batch Pengaturan XRDP & Tools"

  # --- Step wording
  LANG_STEP_DEPS="Install dependensi dasar"
  LANG_STEP_DESKTOP="Install Desktop Environment"
  LANG_STEP_XRDP="Install XRDP Core"
  LANG_STEP_CHROME="Install Google Chrome"
  LANG_STEP_VLC="Install VLC"
  LANG_STEP_VSCODE="Install VSCode"
  LANG_STEP_CONFIG="Konfigurasi tambahan"
  LANG_STEP_UN_XRDP="Uninstall XRDP Core"
  LANG_STEP_UN_DESKTOP="Uninstall Desktop Env"
  LANG_STEP_UN_CHROME="Uninstall Google Chrome"
  LANG_STEP_UN_VLC="Uninstall VLC"
  LANG_STEP_UN_VSCODE="Uninstall VSCode"
  LANG_STEP_UN_CONKY="Uninstall Conky/Config"

  # --- VSCode Extension Wizard/Extension Menu
  LANG_EXT_MENU_TITLE="🧩 Wizard Extension VSCode"
  LANG_EXT_DEFAULT="1. Default: Install extension yang direkomendasikan (otomatis)"
  LANG_EXT_CUSTOM="2. Kustom: Pilih extension berdasarkan kategori"
  LANG_EXT_CATEGORY_PROMPT="Pilih kategori extension yang ingin diinstall:"
  LANG_EXT_CHOOSE_PROMPT="Ketik nomor kategori (pisahkan dengan spasi):"
  LANG_EXT_LIST_PROMPT="Pilih extension yang ingin diinstall dari kategori ini:"
  LANG_EXT_CHOOSE_EXT_PROMPT="Ketik nomor extension (pisahkan dengan spasi):"
  LANG_EXT_SAVE="11. Simpan & Install"
  LANG_EXT_BACK="0. Kembali"
  LANG_EXT_CHOSEN="Anda memilih extension:"
  LANG_EXT_INSTALL="Install extension..."
  LANG_EXT_DONE="✅ Semua extension selesai diinstall!"
  LANG_EXT_ERR_EMPTY="Tidak ada extension yang dipilih."
  LANG_EXT_ERR_NO_EXT="Tidak ada file extension untuk uninstall!"
  LANG_EXT_ERR_NOT_FOUND="File extension tidak ditemukan!"

  # --- VSCode uninstall wording
  LANG_UNINSTALL_VSCODE_EXTENSIONS="🗑️  Menghapus extension VSCode..."
  LANG_UNINSTALL_VSCODE_APP="🗑️  Menghapus aplikasi VSCode..."
  LANG_UNINSTALL_VSCODE_ALL="🗑️  Menghapus aplikasi & seluruh extension VSCode..."

  # --- General errors
  LANG_ERROR_MARKER="❌ Gagal membuat marker!"
  LANG_LOGGING_ERROR="❌ Gagal mencatat log error!"
fi

# =======================
# English (en)
# =======================
if [ "$LANG_SET" = "en" ]; then
  LANG_MENU_INSTALL="🚀 Install XRDP + Desktop Environment"
  LANG_MENU_UNINSTALL="❌ Uninstall XRDP & Desktop Environment"
  LANG_MENU_TOOLS="🛠️  Install XRDP apps/tools"
  LANG_MENU_INFO="ℹ️  Info & Status"
  LANG_MENU_SET="🔧 Configuration/SET"
  LANG_MENU_EXIT="🚪 Exit"
  LANG_MENU_PROMPT="Choose menu (1/2/3/4/5/6):"
  LANG_INVALID_OPTION="❌ Invalid option!"
  LANG_SUCCESS_INSTALL="✅ Installation complete!"
  LANG_SUCCESS_UNINSTALL="✅ Uninstall complete!"
  LANG_GOODBYE="👋 Goodbye!"
  LANG_WARN_ALREADY_INSTALLED="⚠️  Already configured."
  LANG_BACK_TO_MAIN_MENU="↩️  Back to main menu"
  LANG_BACK_MAIN="↩️  Back to main menu in 10 seconds... (press Enter to return immediately)"

  LANG_TOOLS_MENU_TITLE="📦 Install XRDP Apps/Tools"
  LANG_TOOLS_INSTALL_ALL="Install All Tools"
  LANG_TOOLS_MENU_PROMPT="Choose tools menu (1/2/3/4):"

  LANG_SET_MENU_TITLE="🔧 XRDP/Tools Configuration"
  LANG_SET_DESKTOP_LANG="🌐 Set Desktop Language (XRDP GUI)"
  LANG_SET_TERMINAL_LANG="🗣️  Set Terminal/Script Language"
  LANG_SET_PORT="🔢 Set XRDP Port"
  LANG_SET_TIMEZONE="🌏 Set Timezone"
  LANG_SET_VPS_INFO="📊 Set/Reset VPS Info (Conky)"
  LANG_SET_SUCCESS="✅ Setting successful!"
  LANG_SET_FAIL="❌ Setting failed!"
  LANG_BACK_TO_TOOLS="↩️  Back to tools menu"
  LANG_STEP_SET_LANG_TERM="Set Terminal Language"
  LANG_STEP_SET_LANG_GUI="Set Desktop Language (GUI)"
  LANG_STEP_SET_PORT="Set XRDP Port"
  LANG_STEP_SET_TZ="Set Timezone"
  LANG_STEP_SET_CONKY="Set VPS Info/Conky"

  LANG_INFO_TITLE="ℹ️  Info & XRDP VPS Status"
  LANG_TIPS_STATUS="💡 Tips: Use SET menu for advanced configuration."
  LANG_ALREADY_INSTALLED="✅ already installed"
  LANG_ALREADY_UNINSTALLED="❌ already removed!"
  LANG_STEP_DONE="✅ Done"
  LANG_FAIL_EMOJI="❌ Failed!"
  LANG_SUCCESS_EMOJI="✅"
  LANG_WARN_EMOJI="⚠️"
  LANG_UNINSTALL_ALL_TITLE="❌ Uninstall XRDP & All Components"
  LANG_UNINSTALL_DONE="✅ Uninstall complete!"
  LANG_BATCH_ALREADY_INSTALLED="⚠️  Batch already installed!"
  LANG_BATCH_ALREADY_CONFIGURED="⚠️  Batch SET already completed!"
  LANG_BATCH_SUCCESS="✅ Batch installation successful!"
  LANG_BATCH_FAIL="❌ Batch installation encountered errors!"
  LANG_BATCH_UNINSTALL_SUCCESS="✅ Batch uninstall successful!"
  LANG_BATCH_UNINSTALL_FAIL="❌ Batch uninstall encountered errors!"
  LANG_BATCH_SET_SUCCESS="✅ Batch configuration completed!"

  LANG_BATCH_INSTALL_TITLE="🚀 Install Batch XRDP + Desktop + Tools"
  LANG_BATCH_UNINSTALL_TITLE="❌ Uninstall Batch XRDP + Desktop + Tools"
  LANG_BATCH_SET_TITLE="🔧 Batch Configuration XRDP & Tools"

  LANG_STEP_DEPS="Install base dependencies"
  LANG_STEP_DESKTOP="Install Desktop Environment"
  LANG_STEP_XRDP="Install XRDP Core"
  LANG_STEP_CHROME="Install Google Chrome"
  LANG_STEP_VLC="Install VLC"
  LANG_STEP_VSCODE="Install VSCode"
  LANG_STEP_CONFIG="Additional configuration"
  LANG_STEP_UN_XRDP="Uninstall XRDP Core"
  LANG_STEP_UN_DESKTOP="Uninstall Desktop Env"
  LANG_STEP_UN_CHROME="Uninstall Google Chrome"
  LANG_STEP_UN_VLC="Uninstall VLC"
  LANG_STEP_UN_VSCODE="Uninstall VSCode"
  LANG_STEP_UN_CONKY="Uninstall Conky/Config"

  LANG_EXT_MENU_TITLE="🧩 VSCode Extension Wizard"
  LANG_EXT_DEFAULT="1. Default: Install recommended extensions (auto)"
  LANG_EXT_CUSTOM="2. Custom: Choose extensions by category"
  LANG_EXT_CATEGORY_PROMPT="Choose extension categories to install:"
  LANG_EXT_CHOOSE_PROMPT="Type category numbers (separate by space):"
  LANG_EXT_LIST_PROMPT="Choose extensions to install from this category:"
  LANG_EXT_CHOOSE_EXT_PROMPT="Type extension numbers (separate by space):"
  LANG_EXT_SAVE="11. Save & Install"
  LANG_EXT_BACK="0. Back"
  LANG_EXT_CHOSEN="You chose extensions:"
  LANG_EXT_INSTALL="Installing extensions..."
  LANG_EXT_DONE="✅ All extensions installed!"
  LANG_EXT_ERR_EMPTY="No extensions selected."
  LANG_EXT_ERR_NO_EXT="No extension file for uninstall!"
  LANG_EXT_ERR_NOT_FOUND="Extension file not found!"

  LANG_UNINSTALL_VSCODE_EXTENSIONS="🗑️  Removing VSCode extensions..."
  LANG_UNINSTALL_VSCODE_APP="🗑️  Removing VSCode app..."
  LANG_UNINSTALL_VSCODE_ALL="🗑️  Removing VSCode app & all extensions..."

  LANG_ERROR_MARKER="❌ Failed to create marker!"
  LANG_LOGGING_ERROR="❌ Failed to write error log!"
fi

# Usage: 
# . ./set/set-language.sh
# echo "${LANG_MENU_INSTALL}"
# echo "${LANG_EXT_MENU_TITLE}"
# echo "${LANG_UNINSTALL_VSCODE_ALL}"