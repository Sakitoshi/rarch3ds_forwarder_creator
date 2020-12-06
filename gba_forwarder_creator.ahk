#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoTrayIcon
#SingleInstance off

Version = 1.5.0
system = gba
bios = gba_bios.bin
bios_name = GBA Bios
system_name = GBA
system_pc = GBA
publisher_name = Nintendo
rom_ext = gba
sound = tools\assets_%system%\gba.wav
banner_size = 192x128
remapping = 1
showcoreoptions = 0
#Include rarch3ds_forwarder_creator_gui.ahk
#Include rarch3ds_forwarder_creator_functions.ahk
checkromdependency()
{
Return
}
cps1or2()
{
Return
}