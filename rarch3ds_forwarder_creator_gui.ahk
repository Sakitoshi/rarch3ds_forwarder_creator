If system =
    {
    MsgBox, >:(
    ExitApp
    }

Title = %system_name% Forwarder Creator
;Version = 1.5.2C

IfNotExist tools
    {
    MsgBox, 16, %Title% %Version%, tools folder missing.`n`nERROR 0x00
    ExitApp
    }

remapguicreated = 0
coreoptionscreated = 0
ShowTouch = 1
DPI_Mult := A_ScreenDPI / 96
Window_W := 358 * DPI_Mult
Window_H := 355 * DPI_Mult
Banner_X := Ceil(6 * DPI_Mult)
Banner_Y := Ceil(4 * DPI_Mult)
Banner_W := Ceil(256 * DPI_Mult)
Banner_H := Ceil(128 * DPI_Mult)
Icon_X := Ceil(270 * DPI_Mult)
Icon_Y := Ceil(84 * DPI_Mult)
Icon_WH := Ceil(48 * DPI_Mult)

Gui, Add, Picture, xm+6 ym+4 w256 h128 section, tools\assets_%system%\banner_border.png
If remapping = 1
    Gui, Add, Button, x+7 ym+3 w50 h50 gremapgui, Remap Buttons
If showcoreoptions = 1
    Gui, Add, Button, x+7 ym+3 w50 h50 gcoreoptionsgui, Emulator Options
Gui, Add, Picture, xs+264 ys+80 w48 h48, tools\assets_%system%\icon_border.png
Gui, Add, Button, xm-1 y+9 section gBannerImage, Banner Image
Gui, Add, Text, x+5 ys+4 section, Product Code: %system_pc%-P-
Gui, Add, Edit, x+2 ys-3 w50 r1 Limit4 Wrap Uppercase vProductCodeEdit, % randomproductcode()
Gui, Add, Text, x+5 ys section, Unique ID:
Gui, Add, Edit, x+2 ys-3 w40 r1 Limit4 Number Wrap Uppercase vUniqueIDEdit, % randomuniqueid()
Gui, Add, Button, xm-1 section gSelectRom, Select Game
Gui, Add, Text, ys+4 w200 vSelectedRom, None...
Gui, Add, Text, xm-1 y+16 section, %bios_name%:
Gui, Add, Edit, ys-3 w102 Wrap -Tabstop ReadOnly cFF7F00 vBiosEdit, checking...
;If system = neogeo
;    Gui, Add, Checkbox, ys Disabled vUnibiosCheck, Enable Uni-bios menu
If system = ps1
    {
    Gui, Add, Text, x+58 ys, Core Version:
    Gui, Add, Edit, ys-3 w50 r1 Wrap -Tabstop ReadOnly vCoreVersionEdit, %coreversion%
    }
Gui, Add, Text, xm-1 ym+233 section, Long Name:
Gui, Add, Text, xm-1 y+16, Short Name:
Gui, Add, Text, xm-1 y+16, Publisher:
Gui, Add, Edit, ys-3 w270 Limit256 vLongNameEdit, %system_name% Virtual Console
Gui, Add, Edit, xp y+8 w270 Limit128 vShortNameEdit, %system_name% VC
Gui, Add, Edit, xp y+8 w270 Limit128 vPublisherEdit, %publisher_name%
Gui, Add, Button, xm-1 y+9 w340 gBuildCia, Build Cia
Gui, -DPIScale +Hwndmgui
SetTimer, WatchEdit, 10
Gui, Show, w%Window_W% h%Window_H%, %Title% %Version%

bioszip := CheckBiosFile(bios)
If bioszip = neonormalbios
    {
    GuiControl,, BiosEdit, Normal bios detected
    Gui, Font, cBlue
    }
Else If bioszip = neounibios
    {
    GuiControl,, BiosEdit, Uni-bios detected
    Gui, Font, cGreen
    GuiControl, Enabled, UnibiosCheck
    GuiControl,, UnibiosCheck, 1
    }
Else If bioszip = neooldbios
    {
    bioszip = 0
    GuiControl,, BiosEdit, Bios is too old
    Gui, Font, cRed
    }
Else If bioszip = neoancientbios
    {
    bioszip = 0
    GuiControl,, BiosEdit, Neorage bios, too old
    Gui, Font, cRed
    }
Else If bioszip = neounknownbios
    {
    bioszip = 0
    GuiControl,, BiosEdit, Couldn't identify bios
    Gui, Font, cRed
    }
Else If bioszip = qsound
    {
    GuiControl,, BiosEdit, QSound bios OK
    Gui, Font, cGreen
    }
Else If bioszip = bin
    {
    GuiControl,, BiosEdit, %system_name% bios present
    Gui, Font, cGreen
    }
Else If bioszip contains .bin
    {
    GuiControl, MoveDraw, BiosEdit, w152
    GuiControl,, BiosEdit, %bioszip% bios present
    Gui, Font, cGreen
    }
Else
    {
    If system = ps1
        {
        GuiControl,, BiosEdit, Using HLE bios
        Gui, Font, cFF7F00
        }
    Else
        {
        GuiControl,, BiosEdit, No bios detected
        Gui, Font, cRed
        }
    }
GuiControl, Font, BiosEdit
Return

remapgui:
#Include rarch3ds_forwarder_creator_remap.ahk
Return

coreoptionsgui:
#Include rarch3ds_forwarder_creator_coreoptions.ahk
Return

BannerImage:
Gui, +OwnDialogs
GuiControlGet, BannerPreview,, BannerPreview
FileSelectFile, bannerimage, 1,, Select Banner/Icon Image, Images (*.bmp; *.jpg; *.jpeg; *.jpe; *.jfif; *.png; *.gif)
If ErrorLevel = 1
    Return
bannerimageprev = %A_Temp%\bannerpreview.png
iconimageprev = %A_Temp%\iconpreview.png
RunWait, tools\convert.exe -scale %banner_size%! "%bannerimage%" -size 256x128 tools\assets_%system%\banner_border.png +swap -gravity center -composite %bannerimageprev%,, Hide
RunWait, tools\convert.exe -scale 40x40 "%bannerimage%" -size 48x48 tools\assets_%system%\icon_border.png +swap -gravity center -composite %iconimageprev%,, Hide
If BannerPreview =
    {
    Gui, Add, Picture, xm%Banner_X% ym%Banner_Y% w%Banner_W% h%Banner_H% vBannerPreview, %bannerimageprev%
    GuiControl,, BannerPreview, %bannerimageprev%
    Gui, Add, Picture, xm%Icon_X% ym%Icon_Y% w%Icon_WH% h%Icon_WH% vIconPreview, %iconimageprev%
    GuiControl,, IconPreview, %iconimageprev%
    }
Else
    {
    GuiControl,, BannerPreview, %bannerimageprev%
    GuiControl,, IconPreview, %iconimageprev%
    }
FileDelete, %bannerimageprev%
FileDelete, %iconimageprev%
Return

SelectRom:
If rom_ext contains `,
    {
    select_rom_ext := system_name " games ("
    Loop, Parse, rom_ext, `,
        select_rom_ext .= "*." A_LoopField ";"
    StringTrimRight, select_rom_ext, select_rom_ext, 1
    select_rom_ext .= ")"
    }
Else
    select_rom_ext = %system_name% games (*.%rom_ext%)
Gui, +OwnDialogs
FileSelectFile, romopen, 1,, Select %system_name% Game, %select_rom_ext%
If ErrorLevel = 1
    Return
rom := romopen
SplitPath, rom, romshort, romdir, fileext, romname
rom2short := checkromdependency()
If rom2short = %romshort%
    rom2short =
IfInString system, cps
    system := cps1or2()
Gui, Font
GuiControl, Font, SelectedRom
If fileext not in %rom_ext%
    {
    rom =
    romshort = The game must be in %rom_ext% format.
    Gui, Font, cRed
    GuiControl, Font, SelectedRom
    }
If rom2short =
    {
    rom2 =
    GuiControl,, SelectedRom, %romshort%
    }
Else If rom2short !=
    {
    rom2 = %romdir%\%rom2short%
    If (!FileExist(rom2) && system != "ps1")
        {
        MsgBox, This rom needs the parent rom "%rom2short%"`nPlease place it alongside it.
        rom =
        romshort = The needed parent rom isn't present.
        Gui, Font, cRed
        GuiControl, Font, SelectedRom
        GuiControl,, SelectedRom, %romshort%
        }
    Else If system = ps1
        {
        rom2 = %rom2short%
        GuiControl,, SelectedRom, %romshort% + %rom2% SBI
        }
    Else
        GuiControl,, SelectedRom, %romshort% + %rom2short%
    }
GuiControl,, ProductCodeEdit, % randomproductcode()
GuiControl,, UniqueIDEdit, % randomuniqueid()
Return

BuildCia:
Gui, Submit, NoHide
If bioszip = 0
    If !(system = "cps1" || system = "ps1")
    {
    MsgBox, 48, %A_Space%, You need a bios file first.`n`nCopy your %bios% bios to the same folder of this program.
    Return
    }
If system = neogeo
    GuiControlGet, Unibios,, UnibiosCheck
If system = ps1
    GuiControlGet, Unibios,, HLEbiosCheck
If rom =
    {
    MsgBox, 48, %A_Space%, You haven't selected a rom yet.
    Return
    }
FileSelectFile, CiaName, S16, %romname%.cia, Select where to save the Cia, Cia files (*.cia)
If ErrorLevel = 1
    Return

Gui, 2:Add, Text, w200 vBuildText, Working...
Gui, 2:Add, Progress, -Smooth Range0-6 w200 vBuildProgress
Gui, 2:Show,, %Title% - Building
Gui, 2:+Owner%mgui% -Sysmenu
Gui, %mgui%:+Disabled
GuiControl, 2:, BuildText, Injecting parameters
Done := createcodebin(romshort)
If Done = 0
    {
    MsgBox,16, %A_Space%, Something went wrong.`n`nERROR 0x01
    Gui, %mgui%:-Disabled
    Gui, 2:Destroy
    Return
    }
GuiControl, 2:, BuildProgress, +1
Done := createretroconfig(UniqueIDEdit)
If Done = 0
    {
    MsgBox,16, %A_Space%, Something went wrong.`n`nERROR 0x02
    Gui, %mgui%:-Disabled
    Gui, 2:Destroy
    Return
    }
Gosub, applyremap
GuiControl, 2:, BuildProgress, +1
GuiControl, 2:, BuildText, Creating banner
Done := createbanner(LongNameEdit,ShortNameEdit,PublisherEdit,bannerimage,sound)
If Done = 0
    {
    MsgBox,16, %A_Space%, Something went wrong.`n`nERROR 0x03
    Gui, %mgui%:-Disabled
    Gui, 2:Destroy
    Return
    }
GuiControl, 2:, BuildProgress, +1
GuiControl, 2:, BuildText, Injecting Retroarch core
Done := buildexefs()
If Done = 0
    {
    MsgBox,16, %A_Space%, Something went wrong.`n`nERROR 0x04
    Gui, %mgui%:-Disabled
    Gui, 2:Destroy
    Return
    }
GuiControl, 2:, BuildProgress, +1
GuiControl, 2:, BuildText, Injecting rom and bios
Done := buildromfs(bios,rom,rom2,Unibios)
If Done = 0
    {
    MsgBox,16, %A_Space%, Something went wrong.`n`nERROR 0x05
    Gui, %mgui%:-Disabled
    Gui, 2:Destroy
    Return
    }
GuiControl, 2:, BuildProgress, +1
GuiControl, 2:, BuildText, Building cia
Done := buildcia(ProductCodeEdit,UniqueIDEdit,CiaName)
If Done = 0
    {
    MsgBox,16, %A_Space%, Something went wrong.`n`nERROR 0x06
    Gui, %mgui%:-Disabled
    Gui, 2:Destroy
    Return
    }
GuiControl, 2:, BuildProgress, +1
GuiControl, 2:, BuildText, Finished
Sleep, 3000
Gui, %mgui%:-Disabled
Gui, 2:Destroy
Return

GuiClose:
ExitApp

WatchEdit:
GuiControlGet, FocusIDEdit, FocusV
If FocusIDEdit = UniqueIDEdit
    {
    Hotkey, A, KeyA, On
    Hotkey, B, KeyB, On
    Hotkey, C, KeyC, On
    Hotkey, D, KeyD, On
    Hotkey, E, KeyE, On
    Hotkey, F, KeyF, On
    }
Else
    {
    Hotkey, A, KeyA, Off
    Hotkey, B, KeyB, Off
    Hotkey, C, KeyC, Off
    Hotkey, D, KeyD, Off
    Hotkey, E, KeyE, Off
    Hotkey, F, KeyF, Off
    }
Return

KeyA:
GuiControl, -Number, UniqueIDEdit
Send, A
GuiControl, +Number, UniqueIDEdit
Return
KeyB:
GuiControl, -Number, UniqueIDEdit
Send, B
GuiControl, +Number, UniqueIDEdit
Return
KeyC:
GuiControl, -Number, UniqueIDEdit
Send, C
GuiControl, +Number, UniqueIDEdit
Return
KeyD:
GuiControl, -Number, UniqueIDEdit
Send, D
GuiControl, +Number, UniqueIDEdit
Return
KeyE:
GuiControl, -Number, UniqueIDEdit
Send, E
GuiControl, +Number, UniqueIDEdit
Return
KeyF:
GuiControl, -Number, UniqueIDEdit
Send, F
GuiControl, +Number, UniqueIDEdit
Return

CheckBiosFile(Zip)
{
    If (Zip = "gba_bios.bin" && system = "gba")
        IfExist gba_bios.bin
            Return, "bin"
    If (Zip = "psxonpsp660.bin|scph101.bin|scph5501.bin|scph7001.bin|scph1001.bin" && system = "ps1")
        {
        If FileExist("psxonpsp660.bin")
            Return, "psxonpsp660.bin"
        If FileExist("scph101.bin")
            Return, "scph101.bin"
        If FileExist("scph5501.bin")
            Return, "scph5501.bin"
        If FileExist("scph7001.bin")
            Return, "scph7001.bin"
        If FileExist("scph1001.bin")
            Return, "scph1001.bin"
        }
    SplitPath, Zip,, SourceFolder
    if ! SourceFolder
        Zip := A_ScriptDir . "\" . Zip

    fso := ComObjCreate("Scripting.FileSystemObject")
    AppObj := ComObjCreate("Shell.Application")
    FolderObj := AppObj.Namespace(Zip)
    FolderItemsObj := FolderObj.Items()
    FileCreateDir, %A_Temp%\bios
    AppObj.Namespace(A_Temp . "\bios").CopyHere(FolderItemsObj, 4|16)
    IfExist, %A_Temp%\bios\uni-bios*.rom
        {
        FileRemoveDir, %A_Temp%\bios, 1
        Return, "neounibios"
        }
    Else IfExist, %A_Temp%\bios\sfix.sfix
        {
        FileRemoveDir, %A_Temp%\bios, 1
        Return, "neonormalbios"
        }
    Else IfExist, %A_Temp%\bios\sfix.sfx
        {
        FileRemoveDir, %A_Temp%\bios, 1
        Return, "neooldbios"
        }
    Else IfExist, %A_Temp%\bios\neo-geo.rom
        {
        FileRemoveDir, %A_Temp%\bios, 1
        Return, "neoancientbios"
        }
    IfExist, %A_Temp%\bios\000-lo.lo
        {
    IfNotExist, %A_Temp%\bios\uni-bios*.rom
        {
    IfNotExist, %A_Temp%\bios\sfix.sfx
        {
        FileRemoveDir, %A_Temp%\bios, 1
        Return, "neounknownbios"
        }
        }
        }
    Else IfExist, %A_Temp%\bios\qsound.bin
        {
        FileRemoveDir, %A_Temp%\bios, 1
        Return, "qsound"
        }
    Else
        FileRemoveDir, %A_Temp%\bios, 1
        Return, 0
}
