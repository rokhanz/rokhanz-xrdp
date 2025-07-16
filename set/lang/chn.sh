#!/bin/bash
# language: Chinese
# Version: 1.0.0
# License: MIT
# Copyright (c) 2025 rokhanz

LANG_NAME="中文"
LANG_EMOJI="🇨🇳"

# 主菜单和全局
LANG_MENU_INSTALL=" Install XRDP + 桌面环境"
LANG_MENU_UNINSTALL="❌ 卸载 XRDP & 桌面环境"
LANG_MENU_TOOLS="️ 安装 XRDP 应用/工具"
LANG_EXT_MENU_TITLE="🧩VSCode 扩展向导"
LANG_MENU_INFO="ℹ️ 信息 & 状态"
LANG_MENU_SET=" 设置/SET"
LANG_MENU_EXIT=" 退出"
LANG_MENU_PROMPT="选择菜单 (1/2/3/4/5/6):"
LANG_INVALID_OPTION="❌ 无效的选项!"
LANG_SUCCESS_INSTALL="✅ 安装完成!"
LANG_SUCCESS_UNINSTALL="✅ 卸载完成!"
LANG_GOODBYE=" 再见!"
LANG_WARN_ALREADY_INSTALLED="⚠️ 已经设置过。"
LANG_BACK_TO_MAIN_MENU="↩️ 返回主菜单"
LANG_BACK_MAIN="↩️ 10 秒后返回主菜单... (按 Enter 立即返回)"

# 添加新用户
LANG_ADD_XRDP_USER_TITLE="=== 👤 添加 XRDP 用户 ==="
LANG_ADD_XRDP_USER_PROMPT="输入新的用户名："
LANG_ADD_XRDP_USER_EXISTS="⚠️  用户已存在。"
LANG_ADD_XRDP_USER_SUCCESS="✅ 用户创建成功。"
LANG_ADD_XRDP_USER_FAIL="❌ 用户创建失败。"
LANG_ADD_XRDP_USER_PASS_PROMPT="输入密码："
LANG_ADD_XRDP_USER_PASS_SET="✅ 密码已设置。"
LANG_ADD_XRDP_USER_PASS_FAIL="❌ 密码设置失败。"
LANG_ADD_XRDP_USER_SUDO_PROMPT="将用户添加到sudo组？(y/n)："
LANG_ADD_XRDP_USER_SUDO_OK="✅ 用户已添加到sudo组。"
LANG_ADD_MENU_XRDP="➕ 添加新用户"

# 工具菜单
LANG_TOOLS_MENU_TITLE=" 安装 XRDP 应用/工具"
LANG_TOOLS_INSTALL_ALL="安装所有工具"
LANG_TOOLS_MENU_PROMPT="选择工具菜单 (1/2/3/4):"

# 设置菜单
LANG_SET_MENU_TITLE=" XRDP & 工具 设置/SET"
LANG_SET_DESKTOP_LANG=" 设置桌面语言 (XRDP GUI)"
LANG_SET_TERMINAL_LANG="️ 设置 终端/脚本 语言"
LANG_SET_PORT=" 设置 XRDP 端口"
LANG_SET_TIMEZONE=" 设置 时区"
LANG_SET_VPS_INFO=" 设置/重置 VPS 信息 (Conky)"
LANG_SET_SUCCESS="✅ 设置成功!"
LANG_SET_FAIL="❌ 设置失败!"
LANG_BACK_TO_TOOLS="↩️ 返回工具菜单"

# 信息 & 状态
LANG_INFO_TITLE="ℹ️ XRDP VPS 信息 & 状态"
LANG_TIPS_STATUS=" 提示: 使用 SET 菜单进行高级设置."
LANG_ALREADY_INSTALLED="✅ 已安装"
LANG_ALREADY_UNINSTALLED="❌ 已卸载!"
LANG_STEP_DONE="✅ 完成"
LANG_FAIL_EMOJI="❌ 失败!"
LANG_SUCCESS_EMOJI="✅"
LANG_WARN_EMOJI="⚠️"

# 批处理文案
LANG_BATCH_ALREADY_INSTALLED="⚠️ 批处理已安装!"
LANG_BATCH_ALREADY_CONFIGURED="⚠️ 已执行批处理 SET!"
LANG_BATCH_SUCCESS="✅ 所有批处理安装成功!"
LANG_BATCH_FAIL="❌ 批处理安装出错!"
LANG_BATCH_UNINSTALL_SUCCESS="✅ 所有批处理卸载成功!"
LANG_BATCH_UNINSTALL_FAIL="❌ 批处理卸载出错!"
LANG_BATCH_SET_SUCCESS="✅ 所有批处理设置完成!"
LANG_BATCH_INSTALL_TITLE=" Install Batch XRDP + 桌面 + 工具"
LANG_BATCH_UNINSTALL_TITLE="❌ Uninstall Batch XRDP + 桌面 + 工具"
LANG_BATCH_SET_TITLE=" Batch 设置 XRDP & 工具"

# 步骤文案
LANG_STEP_DEPS="安装基本依赖"
LANG_STEP_DESKTOP="安装桌面环境"
LANG_STEP_XRDP="安装 XRDP 核心"
LANG_STEP_CHROME="安装 Google Chrome"
LANG_STEP_VLC="安装 VLC"
LANG_STEP_VSCODE="安装 VSCode"
LANG_STEP_CONFIG="附加配置"
LANG_STEP_UN_XRDP="卸载 XRDP 核心"
LANG_STEP_UN_DESKTOP="卸载桌面环境"
LANG_STEP_UN_CHROME="卸载 Google Chrome"
LANG_STEP_UN_VLC="卸载 VLC"
LANG_STEP_UN_VSCODE="卸载 VSCode"
LANG_STEP_UN_CONKY="卸载 Conky/配置"

# 扩展向导
LANG_EXT_MENU_TITLE=" VSCode 扩展向导"
LANG_EXT_DEFAULT="1. 默认: 安装推荐扩展 (自动)"
LANG_EXT_CUSTOM="2. 自定义: 按类别选择扩展"
LANG_EXT_CATEGORY_PROMPT="选择要安装的扩展类别:"
LANG_EXT_CHOOSE_PROMPT="输入类别编号 (用空格分隔):"
LANG_EXT_LIST_PROMPT="从此类别中选择要安装的扩展:"
LANG_EXT_CHOOSE_EXT_PROMPT="输入扩展编号 (用空格分隔):"
LANG_EXT_SAVE="11. 保存 & 安装"
LANG_EXT_BACK="0. 返回"
LANG_EXT_CHOSEN="您选择的扩展:"
LANG_EXT_INSTALL="正在安装扩展..."
LANG_EXT_DONE="✅ 所有扩展已安装!"
LANG_EXT_ERR_EMPTY="未选择任何扩展."
LANG_EXT_ERR_NO_EXT="没有可卸载的扩展文件!"
LANG_EXT_ERR_NOT_FOUND="未找到扩展文件!"

# 卸载 VSCode
LANG_UNINSTALL_VSCODE_EXTENSIONS="️ 正在删除 VSCode 扩展..."
LANG_UNINSTALL_VSCODE_APP="️ 正在删除 VSCode 应用..."
LANG_UNINSTALL_VSCODE_ALL="️ 删除应用 & 所有 VSCode 扩展..."

# 通用错误
LANG_ERROR_MARKER="❌ 创建标记失败!"
LANG_LOGGING_ERROR="❌ 记录错误日志失败!"
