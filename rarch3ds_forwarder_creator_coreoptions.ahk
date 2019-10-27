If coreoptionsguicreated = 1
    Goto, coreoptionsguiopen

Gui, core:Add, Checkbox, Checked vVsync, Vertical Sync (Vsync)
Gui, core:Add, Checkbox, vHLEbiosCheck, Use HLE bios
Gui, core:Add, Text, y+12, Frameskip
Gui, core:Add, DropDownList, vFrameskip, 0||1|2|3|
Gui, core:Add, Checkbox, y+12 vMemcard2, Enable Second Memory card
Gui, core:Add, Text, y+12, Pad 1 Type
Gui, core:Add, DropDownList, vPad1, standard||analog|dualshock|negcon|none|
;Gui, core:Add, Checkbox, vCpadDpad, Use Circlepad as Dpad
Gui, core:Add, Checkbox, Checked vShowTouch, Show Touchscreen buttons
Gui, core:Add, Text, , NegCon Twist Deadzone (Percent)
Gui, core:Add, DropDownList, vNegDZ, 0||5|10|15|20|25|30|
Gui, core:Add, Text, , NegCon Twist Response
Gui, core:Add, DropDownList, vNegResp, linear||quadratic|cubic|
Gui, core:Add, Checkbox, y+12 Checked vDither, Enable Dithering
Gui, core:Add, Text, y+12, PSX CPU Clock
Gui, core:Add, Edit, w60 vPSXClockText gClockRange
Gui, core:Add, UpDown, Section Range30-100 vPSXClock, 50
Gui, core:Add, Checkbox, ym Checked vAudio, Enable Audio
Gui, core:Add, Text,, Sound Interpolation
Gui, core:Add, DropDownList, vSoundInter, simple|gaussian||cubic|off|
Gui, core:Add, Checkbox, y+12 vShowBios, Show Bios Bootlogo
Gui, core:Add, Text, xp+17 y+1 r1 vShowBiosT, Breaks some games.
Gui, core:Add, Checkbox, xp-17 y+3 vFixDiablo, Diablo Music Fix
Gui, core:Add, Checkbox, vFixPE2VH2, Parasite Eve 2/Vandal Hearts 1/2 Fix
Gui, core:Add, Checkbox, vFixInu, Inuyasha Sengoku Battle Fix
Gui, core:Add, Checkbox, y+12 Checked vUnaiBlend, (GPU) Enable Blending
Gui, core:Add, Checkbox, Checked vUnaiLight, (GPU) Enable Lightning
Gui, core:Add, Checkbox, vUnaiIlace, (GPU) Enable Forced Interlace
Gui, core:Add, Checkbox, vUnaiPixSkip, (GPU) Enable Pixel Skip
Gui, core:Add, Checkbox, y+12 vSHSMC, (Speed Hack) Disable SMC Checks
Gui, core:Add, Text, xp+17 y+1 r1 vSHSMCT, Will cause crashes when loading`, break memcards.
Gui, core:Add, Checkbox, xp-17 y+2 vSHGTERegs, (Speed Hack) Assume GTE Regs Unneeded
Gui, core:Add, Text, xp+17 y+1 r1 vSHGTERegsT, May cause graphical glitches.
Gui, core:Add, Checkbox, xp-17 y+2 vSHGTEFlags, (Speed Hack) Disable GTE Flags
Gui, core:Add, Text, xp+17 y+1 r1 vSHGTEFlagsT, Will cause graphical glitches.
Gui, core:Add, Text, xm+0 ys+36, Quick presets:
Gui, core:Add, Button, xp-1 y+4 gcorePMaxS, Max Speed
Gui, core:Add, Button, x+8 gcorePTurbo, Turbo
Gui, core:Add, Button, x+8 gcorePFast, Fast
Gui, core:Add, Button, x+8 gcorePSafe, Safe
Gui, core:Add, Button, x+8 gcorePQuality, Quality
Gui, core:Add, Button, xm-1 y+8 gcoreReset, Reset
Gui, core:Add, Button, x+8 yp gcoreCancel, Cancel
Gui, core:Add, Button, x+8 yp gcoreOK, OK
Gui, core:Font, s7, MS Shell Dlg 2
GuiControl, core:Font, ShowBiosT
GuiControl, core:Font, SHSMCT
GuiControl, core:Font, SHGTERegsT
GuiControl, core:Font, SHGTEFlagsT
coreoptionsguicreated = 1
coreoptionsOKpressed = 0
coreoptionsguiopen:
Gui, core:Show,, %Title% - Emulator Options
Gui, core:+Owner%mgui% -Sysmenu
Gui, %mgui%:+Disabled
Return

ClockRange:
GuiControlGet, PSXClockText, core:, PSXClockText
If PSXClockText < 30
    GuiControl, core:, PSXClockText, 30
If PSXClockText > 100
    GuiControl, core:, PSXClockText, 100
Return

corePMaxS:
GuiControl, core:, Vsync, 0
GuiControl, core:ChooseString, Frameskip, 1
GuiControl, core:, Dither, 0
GuiControl, core:, PSXClock, 30
GuiControl, core:, Audio, 0
GuiControl, core:ChooseString, SoundInter, off
GuiControl, core:, UnaiBlend, 0
GuiControl, core:, UnaiLight, 0
GuiControl, core:, UnaiIlace, 1
GuiControl, core:, UnaiPixSkip, 1
GuiControl, core:, SHSMC, 1
GuiControl, core:, SHGTERegs, 1
GuiControl, core:, SHGTEFlags, 1
Return

corePTurbo:
GuiControl, core:, Vsync, 0
GuiControl, core:ChooseString, Frameskip, 0
GuiControl, core:, Dither, 0
GuiControl, core:, PSXClock, 32
GuiControl, core:, Audio, 1
GuiControl, core:ChooseString, SoundInter, gaussian
GuiControl, core:, UnaiBlend, 1
GuiControl, core:, UnaiLight, 0
GuiControl, core:, UnaiIlace, 0
GuiControl, core:, UnaiPixSkip, 0
GuiControl, core:, SHSMC, 0
GuiControl, core:, SHGTERegs, 1
GuiControl, core:, SHGTEFlags, 1
Return

corePFast:
GuiControl, core:, Vsync, 0
GuiControl, core:ChooseString, Frameskip, 0
GuiControl, core:, Dither, 0
GuiControl, core:, PSXClock, 34
GuiControl, core:, Audio, 1
GuiControl, core:ChooseString, SoundInter, gaussian
GuiControl, core:, UnaiBlend, 1
GuiControl, core:, UnaiLight, 1
GuiControl, core:, UnaiIlace, 0
GuiControl, core:, UnaiPixSkip, 0
GuiControl, core:, SHSMC, 0
GuiControl, core:, SHGTERegs, 1
GuiControl, core:, SHGTEFlags, 0
Return

corePSafe:
GuiControl, core:, Vsync, 0
GuiControl, core:ChooseString, Frameskip, 0
GuiControl, core:, Dither, 0
GuiControl, core:, PSXClock, 37
GuiControl, core:, Audio, 1
GuiControl, core:ChooseString, SoundInter, gaussian
GuiControl, core:, UnaiBlend, 1
GuiControl, core:, UnaiLight, 1
GuiControl, core:, UnaiIlace, 0
GuiControl, core:, UnaiPixSkip, 0
GuiControl, core:, SHSMC, 0
GuiControl, core:, SHGTERegs, 0
GuiControl, core:, SHGTEFlags, 0
Return

corePQuality:
GuiControl, core:, Vsync, 1
GuiControl, core:ChooseString, Frameskip, 0
GuiControl, core:, Dither, 1
GuiControl, core:, PSXClock, 40
GuiControl, core:, Audio, 1
GuiControl, core:ChooseString, SoundInter, gaussian
GuiControl, core:, UnaiBlend, 1
GuiControl, core:, UnaiLight, 1
GuiControl, core:, UnaiIlace, 0
GuiControl, core:, UnaiPixSkip, 0
GuiControl, core:, SHSMC, 0
GuiControl, core:, SHGTERegs, 0
GuiControl, core:, SHGTEFlags, 0
Return

coreReset:
GuiControl, core:, Vsync, 1
GuiControl, core:, HLEbiosCheck, 0
GuiControl, core:ChooseString, Frameskip, 0
GuiControl, core:, Memcard2, 0
GuiControl, core:ChooseString, Pad1, standard
;GuiControl, core:, CpadDpad, 0
GuiControl, core:, ShowTouch, 1
GuiControl, core:ChooseString, NegDZ, 0
GuiControl, core:ChooseString, NegResp, linear
GuiControl, core:, Dither, 1
GuiControl, core:, PSXClock, 50
GuiControl, core:, Audio, 1
GuiControl, core:ChooseString, SoundInter, gaussian
GuiControl, core:, ShowBios, 0
GuiControl, core:, FixDiablo, 0
GuiControl, core:, FixPE2VH2, 0
GuiControl, core:, FixInu, 0
GuiControl, core:, UnaiBlend, 1
GuiControl, core:, UnaiLight, 1
GuiControl, core:, UnaiIlace, 0
GuiControl, core:, UnaiPixSkip, 0
GuiControl, core:, SHSMC, 0
GuiControl, core:, SHGTERegs, 0
GuiControl, core:, SHGTEFlags, 0
Return

coreOK:
coreoptionsOKpressed = 1
Gui, %mgui%:-Disabled
Gui, core:Submit
FileRead, coreoptions, tools\assets_%system%\retroarch-core-options.cfg
FileRead, rarchoptions, tools\assets_%system%\retroarch.cfg
If Vsync != 1
    StringReplace, rarchoptions, rarchoptions,video_vsync = "true",video_vsync = "false"
else
    StringReplace, rarchoptions, rarchoptions,audio_sync = "true",audio_sync = "false"
If Frameskip != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_frameskip = "0",pcsx_rearmed_frameskip = "%Frameskip%"
If Memcard2 != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_memcard2 = "disabled",pcsx_rearmed_memcard2 = "enabled"
If Pad1 != standard
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_pad1type = "standard",pcsx_rearmed_pad1type = "%Pad1%"
;If CpadDpad != 0
;    StringReplace, rarchoptions, rarchoptions,input_player1_analog_dpad_mode = "0",input_player1_analog_dpad_mode = "1"
If NegDZ != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_negcon_deadzone = "0",pcsx_rearmed_negcon_deadzone = "%NegDZ%"
If NegResp != linear
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_negcon_response = "0",pcsx_rearmed_negcon_response = "%NegResp%"
If Dither != 1
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_dithering = "enabled",pcsx_rearmed_dithering = "disabled"
If PSXClock != 50
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_psxclock = "50",pcsx_rearmed_psxclock = "%PSXClock%"
If Audio != 1
    StringReplace, rarchoptions, rarchoptions,audio_enable = "true",audio_enable = "false"
If SoundInter != gaussian
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_spu_interpolation = "gaussian",pcsx_rearmed_spu_interpolation = "%SoundInter%"
If ShowBios != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_show_bios_bootlogo = "disabled",pcsx_rearmed_show_bios_bootlogo = "enabled"
If FixDiablo != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_idiablofix = "disabled",pcsx_rearmed_idiablofix = "enabled"
If FixPE2VH2 != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_pe2fix = "disabled",pcsx_rearmed_pe2fix = "enabled"
If FixInu != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_inuyasha_fix = "disabled",pcsx_rearmed_inuyasha_fix = "enabled"
If UnaiBlend != 1
    StringReplace, coreoptions, coreoptions, pcsx_rearmed_gpu_unai_blending = "enabled", pcsx_rearmed_gpu_unai_blending = "disabled"
If UnaiLight != 1
    StringReplace, coreoptions, coreoptions, pcsx_rearmed_gpu_unai_lighting = "enabled", pcsx_rearmed_gpu_unai_lighting = "disabled"
If UnaiIlace != 0
    StringReplace, coreoptions, coreoptions, pcsx_rearmed_gpu_unai_ilace_force = "disabled", pcsx_rearmed_gpu_unai_ilace_force = "enabled"
If UnaiPixSkip != 0
    StringReplace, coreoptions, coreoptions, pcsx_rearmed_gpu_unai_pixel_skip = "disabled", pcsx_rearmed_gpu_unai_pixel_skip = "enabled"
If SHSMC != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_nosmccheck = "disabled",pcsx_rearmed_nosmccheck = "enabled"
If SHGTERegs != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_gteregsunneeded = "disabled",pcsx_rearmed_gteregsunneeded = "enabled"
If SHGTEFlags != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_nogteflags = "disabled",pcsx_rearmed_nogteflags = "enabled"
Return

coreGuiEscape:
coreCancel:
Gui, %mgui%:-Disabled
Gui, core:Cancel
If coreoptionsOKpressed = 1
    {
    GuiControl, core:, Vsync, %Vsync%
    GuiControl, core:, HLEbiosCheck, %HLEbiosCheck%
    GuiControl, core:ChooseString, Frameskip, %Frameskip%
    GuiControl, core:, Memcard2, %Memcard2%
    GuiControl, core:ChooseString, Pad1, %Pad1%
    ;GuiControl, core:, CpadDpad, %CpadDpad%
    GuiControl, core:, ShowTouch, %ShowTouch%
    GuiControl, core:ChooseString, NegDZ, %NegCon%
    GuiControl, core:ChooseString, NegResp, %NegResp%
    GuiControl, core:, Dither, %Dither%
    GuiControl, core:, PSXClock, %PSXClock%
    GuiControl, core:, Audio, %Audio%
    GuiControl, core:ChooseString, SoundInter, %SoundInter%
    GuiControl, core:, ShowBios, %ShowBios%
    GuiControl, core:, FixDiablo, %FixDiablo%
    GuiControl, core:, FixPE2VH2, %FixPE2VH2%
    GuiControl, core:, FixInu, %FixInu%
    GuiControl, core:, UnaiBlend, %UnaiBlend%
    GuiControl, core:, UnaiLight, %UnaiLight%
    GuiControl, core:, UnaiIlace, %UnaiIlace%
    GuiControl, core:, UnaiPixSkip, %UnaiPixSkip%
    GuiControl, core:, SHSMC, %SHSMC%
    GuiControl, core:, SHGTERegs, %SHGTERegs%
    GuiControl, core:, SHGTEFlags, %SHGTEFlags%
    }
Else
    Gosub, coreReset