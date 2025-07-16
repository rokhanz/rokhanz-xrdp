#!/bin/bash
# language: Thailand
# Version: 1.0.0
# License: MIT
# Copyright (c) 2025 rokhanz

LANG_NAME="Thailand"
LANG_EMOJI="🇹🇭"

# เมนูหลัก & ทั่วไป
LANG_MENU_INSTALL=" ติดตั้ง XRDP + สภาพแวดล้อมเดสก์ท็อป"
LANG_MENU_UNINSTALL="❌ ถอนการติดตั้ง XRDP & สภาพแวดล้อมเดสก์ท็อป"
LANG_MENU_TOOLS="️ ติดตั้งแอป/เครื่องมือ XRDP"
LANG_EXT_MENU_TITLE="🧩ตัวช่วยติดตั้งส่วนขยาย VSCode"
LANG_MENU_INFO="ℹ️ ข้อมูล & สถานะ"
LANG_MENU_SET=" การตั้งค่า/SET"
LANG_MENU_EXIT=" ออก"
LANG_MENU_PROMPT="เลือกเมนู (1/2/3/4/5/6):"
LANG_INVALID_OPTION="❌ ตัวเลือกไม่ถูกต้อง!"
LANG_SUCCESS_INSTALL="✅ การติดตั้งเสร็จสมบูรณ์!"
LANG_SUCCESS_UNINSTALL="✅ ถอนการติดตั้งเสร็จสมบูรณ์!"
LANG_GOODBYE=" แล้วพบกันใหม่!"
LANG_WARN_ALREADY_INSTALLED="⚠️ ตั้งค่าไว้แล้ว"
LANG_BACK_TO_MAIN_MENU="↩️ กลับไปยังเมนูหลัก"
LANG_BACK_MAIN="↩️ กลับไปเมนูหลักใน 10 วินาที... (กด Enter เพื่อกลับทันที)"
# เพิ่มผู้ใช้ใหม่
LANG_ADD_XRDP_USER_TITLE="=== 👤 เพิ่มผู้ใช้ XRDP ==="
LANG_ADD_XRDP_USER_PROMPT="ใส่ชื่อผู้ใช้ใหม่: "
LANG_ADD_XRDP_USER_EXISTS="⚠️  ผู้ใช้นี้มีอยู่แล้ว"
LANG_ADD_XRDP_USER_SUCCESS="✅ สร้างผู้ใช้สำเร็จ"
LANG_ADD_XRDP_USER_FAIL="❌ ไม่สามารถสร้างผู้ใช้ได้"
LANG_ADD_XRDP_USER_PASS_PROMPT="ใส่รหัสผ่าน: "
LANG_ADD_XRDP_USER_PASS_SET="✅ ตั้งค่ารหัสผ่านแล้ว"
LANG_ADD_XRDP_USER_PASS_FAIL="❌ ไม่สามารถตั้งรหัสผ่านได้"
LANG_ADD_XRDP_USER_SUDO_PROMPT="เพิ่มผู้ใช้เข้า sudo group? (y/n): "
LANG_ADD_XRDP_USER_SUDO_OK="✅ เพิ่มผู้ใช้เข้าสู่กลุ่ม sudo แล้ว"
LANG_ADD_MENU_XRDP="➕ เพิ่มผู้ใช้ใหม่"

# เมนูเครื่องมือ
LANG_TOOLS_MENU_TITLE=" ติดตั้งแอป/เครื่องมือ XRDP"
LANG_TOOLS_INSTALL_ALL="ติดตั้งเครื่องมือทั้งหมด"
LANG_TOOLS_MENU_PROMPT="เลือกเมนูเครื่องมือ (1/2/3/4):"

# เมนูการตั้งค่า
LANG_SET_MENU_TITLE=" การตั้งค่า/SET XRDP & เครื่องมือ"
LANG_SET_DESKTOP_LANG=" กำหนดภาษาของเดสก์ท็อป (GUI XRDP)"
LANG_SET_TERMINAL_LANG="️ กำหนดภาษาของเทอร์มินัล/สคริปต์"
LANG_SET_PORT=" กำหนดพอร์ต XRDP"
LANG_SET_TIMEZONE=" กำหนดโซนเวลา"
LANG_SET_VPS_INFO=" กำหนด/รีเซ็ตข้อมูล VPS (Conky)"
LANG_SET_SUCCESS="✅ การตั้งค่าสำเร็จ!"
LANG_SET_FAIL="❌ การตั้งค่าล้มเหลว!"
LANG_BACK_TO_TOOLS="↩️ กลับไปเมนูเครื่องมือ"

# ข้อมูล & สถานะ
LANG_INFO_TITLE="ℹ️ ข้อมูล & สถานะ VPS XRDP"
LANG_TIPS_STATUS=" เคล็ดลับ: ใช้เมนู SET สำหรับการตั้งค่าขั้นสูง"
LANG_ALREADY_INSTALLED="✅ ติดตั้งแล้ว"
LANG_ALREADY_UNINSTALLED="❌ ลบแล้ว!"
LANG_STEP_DONE="✅ เสร็จแล้ว"
LANG_FAIL_EMOJI="❌ ล้มเหลว!"
LANG_SUCCESS_EMOJI="✅"
LANG_WARN_EMOJI="⚠️"

# ชุดคำสั่งแบบกลุ่ม
LANG_BATCH_ALREADY_INSTALLED="⚠️ ชุดติดตั้งถูกติดตั้งแล้ว!"
LANG_BATCH_ALREADY_CONFIGURED="⚠️ ชุดตั้งค่า SET ถูกดำเนินการแล้ว!"
LANG_BATCH_SUCCESS="✅ กระบวนการติดตั้งชุดทั้งหมดสำเร็จ!"
LANG_BATCH_FAIL="❌ พบข้อผิดพลาดในการติดตั้งชุด!"
LANG_BATCH_UNINSTALL_SUCCESS="✅ กระบวนการถอนการติดตั้งชุดทั้งหมดสำเร็จ!"
LANG_BATCH_UNINSTALL_FAIL="❌ พบข้อผิดพลาดในการถอนการติดตั้งชุด!"
LANG_BATCH_SET_SUCCESS="✅ การตั้งค่าชุดทั้งหมดเสร็จสิ้น!"
LANG_BATCH_INSTALL_TITLE=" ติดตั้งชุด XRDP + เดสก์ท็อป + เครื่องมือ"
LANG_BATCH_UNINSTALL_TITLE="❌ ถอนการติดตั้งชุด XRDP + เดสก์ท็อป + เครื่องมือ"
LANG_BATCH_SET_TITLE=" การตั้งค่าชุด XRDP & เครื่องมือ"

# ขั้นตอน
LANG_STEP_DEPS="ติดตั้ง dependencies พื้นฐาน"
LANG_STEP_DESKTOP="ติดตั้งสภาพแวดล้อมเดสก์ท็อป"
LANG_STEP_XRDP="ติดตั้งแกน XRDP"
LANG_STEP_CHROME="ติดตั้ง Google Chrome"
LANG_STEP_VLC="ติดตั้ง VLC"
LANG_STEP_VSCODE="ติดตั้ง VSCode"
LANG_STEP_CONFIG="กำหนดค่าเพิ่มเติม"
LANG_STEP_UN_XRDP="ถอนการติดตั้งแกน XRDP"
LANG_STEP_UN_DESKTOP="ถอนการติดตั้งสภาพแวดล้อมเดสก์ท็อป"
LANG_STEP_UN_CHROME="ถอนการติดตั้ง Google Chrome"
LANG_STEP_UN_VLC="ถอนการติดตั้ง VLC"
LANG_STEP_UN_VSCODE="ถอนการติดตั้ง VSCode"
LANG_STEP_UN_CONKY="ถอนการติดตั้ง Conky/การกำหนดค่า"

# ตัวช่วยส่วนขยาย VSCode
LANG_EXT_MENU_TITLE=" ตัวช่วยติดตั้งส่วนขยาย VSCode"
LANG_EXT_DEFAULT="1. เริ่มต้น: ติดตั้งส่วนขยายที่แนะนำ (อัตโนมัติ)"
LANG_EXT_CUSTOM="2. กำหนดเอง: เลือกส่วนขยายตามหมวดหมู่"
LANG_EXT_CATEGORY_PROMPT="เลือกหมวดหมู่ส่วนขยายที่ต้องการติดตั้ง:"
LANG_EXT_CHOOSE_PROMPT="พิมพ์หมายเลขหมวดหมู่ (คั่นด้วยช่องว่าง):"
LANG_EXT_LIST_PROMPT="เลือกส่วนขยายจากหมวดหมู่นี้:"
LANG_EXT_CHOOSE_EXT_PROMPT="พิมพ์หมายเลขส่วนขยาย (คั่นด้วยช่องว่าง):"
LANG_EXT_SAVE="11. บันทึก & ติดตั้ง"
LANG_EXT_BACK="0. กลับ"
LANG_EXT_CHOSEN="คุณได้เลือกส่วนขยาย:"
LANG_EXT_INSTALL="กำลังติดตั้งส่วนขยาย..."
LANG_EXT_DONE="✅ ส่วนขยายทั้งหมดติดตั้งเสร็จสิ้น!"
LANG_EXT_ERR_EMPTY="ไม่มีส่วนขยายถูกเลือก."
LANG_EXT_ERR_NO_EXT="ไม่มีไฟล์ส่วนขยายสำหรับถอนการติดตั้ง!"
LANG_EXT_ERR_NOT_FOUND="ไม่พบไฟล์ส่วนขยาย!"

# ถอนการติดตั้ง VSCode
LANG_UNINSTALL_VSCODE_EXTENSIONS="️ กำลังลบส่วนขยาย VSCode..."
LANG_UNINSTALL_VSCODE_APP="️ กำลังลบแอป VSCode..."
LANG_UNINSTALL_VSCODE_ALL="️ กำลังลบแอป & ส่วนขยาย VSCode ทั้งหมด..."

# ข้อผิดพลาดทั่วไป
LANG_ERROR_MARKER="❌ ไม่สามารถสร้างเครื่องหมายได้!"
LANG_LOGGING_ERROR="❌ ไม่สามารถบันทึกบันทึกข้อผิดพลาดได้!"
