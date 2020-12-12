#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoTrayIcon
#SingleInstance off

Version = 1.6
system = neogeo
bios = neogeo.zip
bios_name = Neo-Geo Bios
system_name = Neo-Geo
system_pc = NEO
publisher_name = SNK
rom_ext = zip
sound = tools\assets_%system%\neogeo.wav
banner_size = 170x128
remapping = 0
showcoreoptions = 1
#Include rarch3ds_forwarder_creator_gui.ahk
#Include rarch3ds_forwarder_creator_functions.ahk
#Include neogeo_forwarder_creator_db.ahk
cps1or2()
{
Return
}