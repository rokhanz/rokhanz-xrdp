#!/bin/bash
# language: Japanese
# Version: 1.0.0
# License: MIT
# Copyright (c) 2025 rokhanz

LANG_NAME="日本語"
LANG_EMOJI="🇯🇵"

# メインメニュー＆全般
LANG_MENU_INSTALL=" Install XRDP + デスクトップ環境"
LANG_MENU_UNINSTALL="❌ XRDP とデスクトップ環境をアンインストール"
LANG_MENU_TOOLS="️ XRDP アプリ/ツールをインストール"
LANG_MENU_INFO="ℹ️ 情報＆ステータス"
LANG_MENU_SET=" 設定/SET"
LANG_MENU_EXIT=" 終了"
LANG_MENU_PROMPT="メニューを選択 (1/2/3/4/5/6):"
LANG_INVALID_OPTION="❌ 無効な選択です!"
LANG_SUCCESS_INSTALL="✅ インストールが完了しました!"
LANG_SUCCESS_UNINSTALL="✅ アンインストールが完了しました!"
LANG_GOODBYE=" またお会いしましょう!"
LANG_WARN_ALREADY_INSTALLED="⚠️ 既に設定されています."
LANG_BACK_TO_MAIN_MENU="↩️ メインメニューに戻る"
LANG_BACK_MAIN="↩️ 10秒後にメインメニューに戻ります... (Enterキーで即時戻る)"

# ツールメニュー
LANG_TOOLS_MENU_TITLE=" XRDP アプリ/ツールをインストール"
LANG_TOOLS_INSTALL_ALL="すべてのツールをインストール"
LANG_TOOLS_MENU_PROMPT="ツールメニューを選択 (1/2/3/4):"

# 設定メニュー
LANG_SET_MENU_TITLE=" XRDP & ツール 設定/SET"
LANG_SET_DESKTOP_LANG=" デスクトップ言語を設定 (XRDP GUI)"
LANG_SET_TERMINAL_LANG="️ ターミナル/スクリプト言語を設定"
LANG_SET_PORT=" XRDP ポートを設定"
LANG_SET_TIMEZONE=" タイムゾーンを設定"
LANG_SET_VPS_INFO=" VPS 情報を設定/リセット (Conky)"
LANG_SET_SUCCESS="✅ 設定が完了しました!"
LANG_SET_FAIL="❌ 設定に失敗しました!"
LANG_BACK_TO_TOOLS="↩️ ツールメニューに戻る"

# 情報＆ステータス
LANG_INFO_TITLE="ℹ️ XRDP VPS 情報＆ステータス"
LANG_TIPS_STATUS=" ヒント: 詳細設定は SET メニューを使用してください."
LANG_ALREADY_INSTALLED="✅ 既にインストール済み"
LANG_ALREADY_UNINSTALLED="❌ 既にアンインストール済み!"
LANG_STEP_DONE="✅ 完了"
LANG_FAIL_EMOJI="❌ 失敗!"
LANG_SUCCESS_EMOJI="✅"
LANG_WARN_EMOJI="⚠️"

# バッチ用文言
LANG_BATCH_ALREADY_INSTALLED="⚠️ バッチは既にインストールされています!"
LANG_BATCH_ALREADY_CONFIGURED="⚠️ バッチ SET は既に実行されています!"
LANG_BATCH_SUCCESS="✅ すべてのバッチインストールが成功しました!"
LANG_BATCH_FAIL="❌ バッチインストール中にエラーが発生しました!"
LANG_BATCH_UNINSTALL_SUCCESS="✅ すべてのバッチアンインストールが成功しました!"
LANG_BATCH_UNINSTALL_FAIL="❌ バッチアンインストール中にエラーが発生しました!"
LANG_BATCH_SET_SUCCESS="✅ すべてのバッチ設定が完了しました!"
LANG_BATCH_INSTALL_TITLE=" Install Batch XRDP + デスクトップ + ツール"
LANG_BATCH_UNINSTALL_TITLE="❌ Uninstall Batch XRDP + デスクトップ + ツール"
LANG_BATCH_SET_TITLE=" Batch 設定 XRDP & ツール"

# ステップ文言
LANG_STEP_DEPS="基本依存関係をインストール"
LANG_STEP_DESKTOP="デスクトップ環境をインストール"
LANG_STEP_XRDP="XRDP コアをインストール"
LANG_STEP_CHROME="Google Chrome をインストール"
LANG_STEP_VLC="VLC をインストール"
LANG_STEP_VSCODE="VSCode をインストール"
LANG_STEP_CONFIG="追加設定"
LANG_STEP_UN_XRDP="XRDP コアをアンインストール"
LANG_STEP_UN_DESKTOP="デスクトップ環境をアンインストール"
LANG_STEP_UN_CHROME="Google Chrome をアンインストール"
LANG_STEP_UN_VLC="VLC をアンインストール"
LANG_STEP_UN_VSCODE="VSCode をアンインストール"
LANG_STEP_UN_CONKY="Conky/設定をアンインストール"

# 拡張機能ウィザード
LANG_EXT_MENU_TITLE=" VSCode 拡張機能ウィザード"
LANG_EXT_DEFAULT="1. デフォルト: 推奨拡張機能をインストール (自動)"
LANG_EXT_CUSTOM="2. カスタム: カテゴリ別に拡張機能を選択"
LANG_EXT_CATEGORY_PROMPT="インストールする拡張機能のカテゴリを選択:"
LANG_EXT_CHOOSE_PROMPT="カテゴリ番号を入力 (スペースで区切る):"
LANG_EXT_LIST_PROMPT="このカテゴリからインストールする拡張機能を選択:"
LANG_EXT_CHOOSE_EXT_PROMPT="拡張機能番号を入力 (スペースで区切る):"
LANG_EXT_SAVE="11. 保存 & インストール"
LANG_EXT_BACK="0. 戻る"
LANG_EXT_CHOSEN="選択した拡張機能:"
LANG_EXT_INSTALL="拡張機能をインストール中..."
LANG_EXT_DONE="✅ すべての拡張機能をインストールしました!"
LANG_EXT_ERR_EMPTY="拡張機能が選択されていません."
LANG_EXT_ERR_NO_EXT="アンインストールする拡張機能ファイルがありません!"
LANG_EXT_ERR_NOT_FOUND="拡張機能ファイルが見つかりません!"

# VSCode アンインストール
LANG_UNINSTALL_VSCODE_EXTENSIONS="️ VSCode 拡張機能を削除中..."
LANG_UNINSTALL_VSCODE_APP="️ VSCode アプリケーションを削除中..."
LANG_UNINSTALL_VSCODE_ALL="️ アプリケーション & すべての VSCode 拡張機能を削除中..."

# 一般的なエラー
LANG_ERROR_MARKER="❌ マーカーの作成に失敗しました!"
LANG_LOGGING_ERROR="❌ エラーログの記録に失敗しました!"
