If remapguicreated = 1
    Goto, remapguiopen

Gui, remap:Add, DropDownList, ym+16 vbutton5, N3DS A|N3DS B|N3DS X|N3DS Y|N3DS L||N3DS R|N3DS ZL|N3DS ZR|
Gui, remap:Add, DropDownList, y+27 vbutton3, N3DS A|N3DS B|N3DS X||N3DS Y|N3DS L|N3DS R|N3DS ZL|N3DS ZR|
Gui, remap:Add, DropDownList, y+27 vbutton4, N3DS A|N3DS B|N3DS X|N3DS Y||N3DS L|N3DS R|N3DS ZL|N3DS ZR|
Gui, remap:Add, DropDownList, y+27 vbutton7, N3DS A|N3DS B|N3DS X|N3DS Y|N3DS L|N3DS R|N3DS ZL|N3DS ZR|
Gui, remap:Add, Picture, ym-2, tools\assets_%system%\buttons.png
Gui, remap:Add, DropDownList, ym+16 vbutton6, N3DS A|N3DS B|N3DS X|N3DS Y|N3DS L|N3DS R||N3DS ZL|N3DS ZR|
Gui, remap:Add, DropDownList, y+27 vbutton8, N3DS A|N3DS B|N3DS X|N3DS Y|N3DS L|N3DS R||N3DS ZL|N3DS ZR|
Gui, remap:Add, DropDownList, y+27 vbutton1, N3DS A||N3DS B|N3DS X|N3DS Y|N3DS L|N3DS R|N3DS ZL|N3DS ZR|
Gui, remap:Add, DropDownList, y+27 vbutton2, N3DS A|N3DS B||N3DS X|N3DS Y|N3DS L|N3DS R|N3DS ZL|N3DS ZR|
Gui, remap:Add, Button, xp-7 y+28 gremapReset, Reset
Gui, remap:Add, Button, x+8 yp gremapCancel, Cancel
Gui, remap:Add, Button, x+8 yp gremapOK, OK

If system = neogeo
    {
    GuiControl, remap:Hide, button5
    GuiControl, remap:Disable, button5
    ;GuiControl, remap:Hide, button6
    ;GuiControl, remap:Disable, button6
    GuiControl, remap:Hide, button7
    GuiControl, remap:Disable, button7
    GuiControl, remap:Hide, button8
    GuiControl, remap:Disable, button8
    GuiControl, remap:, button6, None||
    }
Else If (system = "cps") || (system = "cps1") || (system = "cps2")
    {
    ;GuiControl, remap:Hide, button6
    ;GuiControl, remap:Disable, button6
    GuiControl, remap:Hide, button7
    GuiControl, remap:Disable, button7
    GuiControl, remap:, button6, None||
    }
Else If system = gba
    {
    GuiControl, remap:Hide, button3
    GuiControl, remap:Disable, button3
    GuiControl, remap:Hide, button8
    GuiControl, remap:Disable, button8
    GuiControl, remap:, button1, N3DS Start|N3DS Select|
    GuiControl, remap:, button2, N3DS Start|N3DS Select|
    GuiControl, remap:, button5, N3DS Start|N3DS Select|
    GuiControl, remap:, button6, N3DS Start|N3DS Select|
    GuiControl, remap:, button4, N3DS Start||N3DS Select|
    GuiControl, remap:, button7, N3DS Start|N3DS Select||
    }

remapguicreated = 1
remapOKpressed = 0
remapguiopen:
Gui, remap:Show,, %Title% - Remap Buttons
Gui, remap:+Owner%mgui% -Sysmenu
Gui, %mgui%:+Disabled
Return

remapReset:
If system = gba
    {
    GuiControl, remap:Choose, button1, 1
    GuiControl, remap:Choose, button2, 2
    GuiControl, remap:Choose, button5, 5
    GuiControl, remap:Choose, button6, 6
    GuiControl, remap:Choose, button4, 9
    GuiControl, remap:Choose, button7, 10
    }
Else
    {
    GuiControl, remap:Choose, button1, 1
    GuiControl, remap:Choose, button2, 2
    GuiControl, remap:Choose, button3, 3
    GuiControl, remap:Choose, button4, 4
    GuiControl, remap:Choose, button5, 5
    GuiControl, remap:Choose, button6, 9
    GuiControl, remap:Choose, button8, 6
    }
Return

remapOK:
remapOKpressed = 1
Gui, %mgui%:-Disabled
Gui, remap:Submit

Loop, 8
    {
    GuiControlGet, button%A_Index%_use, remap:Enabled, button%A_Index%
    If (button%A_Index% = "N3DS A") && (button%A_Index%_use = "1")
        button%A_Index% = 8
    If (button%A_Index% = "N3DS B") && (button%A_Index%_use = "1")
        button%A_Index% = 0
    If (button%A_Index% = "N3DS X") && (button%A_Index%_use = "1")
        button%A_Index% = 9
    If (button%A_Index% = "N3DS Y") && (button%A_Index%_use = "1")
        button%A_Index% = 1
    If (button%A_Index% = "N3DS L") && (button%A_Index%_use = "1")
        button%A_Index% = 10
    If (button%A_Index% = "N3DS R") && (button%A_Index%_use = "1")
        button%A_Index% = 11
    If (button%A_Index% = "N3DS ZL") && (button%A_Index%_use = "1")
        button%A_Index% = 12
    If (button%A_Index% = "N3DS ZR") && (button%A_Index%_use = "1")
        button%A_Index% = 13
    If (button%A_Index% = "N3DS Start") && (button%A_Index%_use = "1")
        button%A_Index% = 3
    If (button%A_Index% = "N3DS Select") && (button%A_Index%_use = "1")
        button%A_Index% = 2
    If (button%A_Index% = "None") && (button%A_Index%_use = "1")
        button%A_Index% = nul
    }
Return

applyremap:
If (remapguicreated = 0) || (remapOKpressed = 0)
    Return

FileRead, rarchconfig, tools\romfs\retroarch.cfg
If system = gba
    {
    If button1 != 8
        StringReplace, rarchconfig, rarchconfig,input_player1_a_btn = "nul",input_player1_a_btn = "%button1%"
    If button2 != 0
        StringReplace, rarchconfig, rarchconfig,input_player1_b_btn = "nul",input_player1_b_btn = "%button2%"
    If button5 != 11
        StringReplace, rarchconfig, rarchconfig,input_player1_l_btn = "nul",input_player1_l_btn = "%button5%"
    If button6 != 12
        StringReplace, rarchconfig, rarchconfig,input_player1_r_btn = "nul",input_player1_r_btn = "%button6%"
    If button4 != 3
        StringReplace, rarchconfig, rarchconfig,input_player1_start_btn = "nul",input_player1_start_btn = "%button4%"
    If button7 != 2
        StringReplace, rarchconfig, rarchconfig,input_player1_select_btn = "nul",input_player1_select_btn = "%button7%"
    }
Else If (system = "cps") || (system = "cps1") || (system = "cps2")
    {
    If button1 != 8
        StringReplace, rarchconfig, rarchconfig,input_player1_a_btn = "nul",input_player1_a_btn = "%button1%"
    If button2 != 0
        StringReplace, rarchconfig, rarchconfig,input_player1_b_btn = "nul",input_player1_b_btn = "%button2%"
    If button3 != 9
        StringReplace, rarchconfig, rarchconfig,input_player1_x_btn = "nul",input_player1_x_btn = "%button3%"
    If button4 != 1
        StringReplace, rarchconfig, rarchconfig,input_player1_y_btn = "nul",input_player1_y_btn = "%button4%"
    If button5 != 11
        StringReplace, rarchconfig, rarchconfig,input_player1_l_btn = "nul",input_player1_l_btn = "%button5%"
    If button8 != 12
        StringReplace, rarchconfig, rarchconfig,input_player1_r_btn = "nul",input_player1_r_btn = "%button8%"
    If button6 != nul
        StringReplace, rarchconfig, rarchconfig,input_player1_turbo_btn = "nul",input_player1_turbo_btn = "%button6%"
    }
Else If system = neogeo
    {
    If button1 != 8
        StringReplace, rarchconfig, rarchconfig,input_player1_a_btn = "nul",input_player1_a_btn = "%button1%"
    If button2 != 0
        StringReplace, rarchconfig, rarchconfig,input_player1_b_btn = "nul",input_player1_b_btn = "%button2%"
    If button3 != 9
        StringReplace, rarchconfig, rarchconfig,input_player1_x_btn = "nul",input_player1_x_btn = "%button3%"
    If button4 != 1
        StringReplace, rarchconfig, rarchconfig,input_player1_y_btn = "nul",input_player1_y_btn = "%button4%"
    If button6 != nul
        StringReplace, rarchconfig, rarchconfig,input_player1_turbo_btn = "nul",input_player1_turbo_btn = "%button6%"
    }
FileDelete, tools\romfs\retroarch.cfg
FileAppend, %rarchconfig%, *tools\romfs\retroarch.cfg, UTF-8-RAW
Return

remapGuiEscape:
remapCancel:
Gui, %mgui%:-Disabled
Gui, remap:Cancel
