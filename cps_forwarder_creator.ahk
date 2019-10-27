#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoTrayIcon
#SingleInstance off

Version = 1.5.3
system = cps
bios = qsound.zip
bios_name = QSound Bios
system_name = CPS
system_pc = CPS
publisher_name = Capcom
rom_ext = zip
sound = tools\assets_%system%\capcom.wav
banner_size = 170x128
remapping = 1
#Include rarch3ds_forwarder_creator_gui.ahk
#Include rarch3ds_forwarder_creator_functions.ahk
#Include cps_forwarder_creator_db.ahk