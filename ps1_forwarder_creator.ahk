#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoTrayIcon
#SingleInstance off

Version = 1.7.3
system = ps1
bios = psxonpsp660.bin|scph101.bin|scph5501.bin|scph7001.bin|scph1001.bin
bios_name = PS1 Bios
system_name = PS1
system_pc = PS1
publisher_name = Sony
rom_ext := "pbp,chd"
sound = tools\assets_%system%\ps1.wav
banner_size = 170x128
remapping = 0
showcoreoptions = 1
#Include rarch3ds_forwarder_creator_gui.ahk
#Include rarch3ds_forwarder_creator_functions.ahk
; #Include ps1_forwarder_creator_db.ahk
checkromdependency()
    {
    global romdir
    global romname
    global fileext

    If FileExist(romdir "\" romname ".sbi")
        Return, "Single"
    If fileext = pbp
        {
        pbp := FileOpen(romdir "\" romname "." fileext, "r", "UTF-8")
        pbp.Seek(0x10000)
        multidisc := pbp.Read(10)
        If (FileExist(romdir "\" romname "_1.sbi") && multidisc = "PSTITLEIMG")
            Return, "Multi"
        }

    }
cps1or2()
{
Return
}