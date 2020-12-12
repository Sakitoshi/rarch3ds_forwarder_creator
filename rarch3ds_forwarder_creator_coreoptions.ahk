If coreoptionsguicreated = 1
    Goto, coreoptionsguiopen

Gui, core:Add, Checkbox, Checked vVsync, Vertical Sync (Vsync)
If system = ps1
  Gui, core:Add, Checkbox, vHLEbiosCheck, Use HLE bios
If system = neogeo
  Gui, core:Add, Text, y+12, Neo-Geo Mode
  Gui, core:Add, DropDownList, vHLEbiosCheck, MVS|AES|UNIBIOS||
Gui, core:Add, Text, y+12, Frameskip
If system = neogeo
  {
  Gui, core:Add, DropDownList, vFrameskip, disabled||Auto|Manual|
  Gui, core:Add, Text, y+12, Frameskip Threshold
  Gui, core:Add, DropDownList, vFrameskipThreshold, 15|18|21|24|27|30|33||36|39|42|45|48|51|54|57|60|
  }
If system = ps1
  {
  Gui, core:Add, DropDownList, vFrameskip, 0||1|2|3|
  Gui, core:Add, Checkbox, y+12 vMemcard2, Enable Second Memory card
  Gui, core:Add, Text, y+12, Pad 1 Type
  Gui, core:Add, DropDownList, vPad1, standard||analog|dualshock|negcon|none|
  ;Gui, core:Add, Checkbox, vCpadDpad, Use Circlepad as Dpad
  }
Gui, core:Add, Text, , Turbo Button
Gui, core:Add, DropDownList, vTurboButton, N3DS A|N3DS B|N3DS X|N3DS Y|N3DS L||N3DS R|N3DS ZL|N3DS ZR|N3DS Left Touch|N3DS Right Touch|None||
Gui, core:Add, Checkbox, Checked vShowTouch, Show Touchscreen buttons
If system = ps1
  {
  Gui, core:Add, Text, , NegCon Twist Deadzone (Percent)
  Gui, core:Add, DropDownList, vNegDZ, 0||5|10|15|20|25|30|
  Gui, core:Add, Text, , NegCon Twist Response
  Gui, core:Add, DropDownList, vNegResp, linear||quadratic|cubic|
  Gui, core:Add, Checkbox, y+12 vDither, Enable Dithering
  Gui, core:Add, Text, y+12, PSX CPU Clock
  Gui, core:Add, Edit, w60 vPSXClockText gClockRange
  Gui, core:Add, UpDown, Section Range30-100 vPSXClock, 50
  }
If system = neogeo
  {
  Gui, core:Add, Text, y+12, CPU Speed (`%)
  Gui, core:Add, Edit, w60 vPSXClockText gClockRange
  Gui, core:Add, UpDown, Section Range100-200 vPSXClock, 100
  }
Gui, core:Add, Checkbox, ym Checked vAudio, Enable Audio
If system = ps1
  {
  Gui, core:Add, Text,, Sound Interpolation
  Gui, core:Add, DropDownList, vSoundInter, simple|gaussian||cubic|off|
  Gui, core:Add, Checkbox, y+12 vShowBios, Show Bios Bootlogo
  Gui, core:Add, Text, xp+17 y+1 r1 vShowBiosT, Breaks some games.
  Gui, core:Add, Checkbox, xp-17 y+3 vFixDiablo, Diablo Music Fix
  Gui, core:Add, Checkbox, vFixPE2VH2, Parasite Eve 2/Vandal Hearts 1/2 Fix
  Gui, core:Add, Checkbox, vFixInu, Inuyasha Sengoku Battle Fix
  Gui, core:Add, Checkbox, y+12 Checked vThreadRend, Threaded Rendering
  Gui, core:Add, Checkbox, Checked vUnaiBlend, (GPU) Enable Blending
  Gui, core:Add, Checkbox, Checked vUnaiLight, (GPU) Enable Lightning
  Gui, core:Add, Checkbox, vUnaiIlace, (GPU) Enable Forced Interlace
  Gui, core:Add, Checkbox, vUnaiPixSkip, (GPU) Enable Pixel Skip
  Gui, core:Add, Checkbox, vUnaiScaleHiRes, (GPU) Enable Hi-Res Downscaling
  Gui, core:Add, Checkbox, y+12 vSHSMC, (Speed Hack) Disable SMC Checks
  Gui, core:Add, Text, xp+17 y+1 r1 vSHSMCT, Will cause crashes when loading`, break memcards.
  Gui, core:Add, Checkbox, xp-17 y+2 vSHGTERegs, (Speed Hack) Assume GTE Regs Unneeded
  Gui, core:Add, Text, xp+17 y+1 r1 vSHGTERegsT, May cause graphical glitches.
  Gui, core:Add, Checkbox, xp-17 y+2 vSHGTEFlags, (Speed Hack) Disable GTE Flags
  Gui, core:Add, Text, xp+17 y+1 r1 vSHGTEFlagsT, Will cause graphical glitches.
  Gui, core:Add, Checkbox, xp-17 y+2 vAsyncCD, Async CD Access
  Gui, core:Add, Text, xp+17 y+1 r1 vAsyncCDT, Can reduce stuttering on devices with slow storage.
  }
If system = neogeo
  {
  Gui, core:Add, Checkbox, y+12 vAudioFilter, Audio Filter
  Gui, core:Add, Text,, Audio Filter Level (`%)
  Gui, core:Add, Edit, w60 vAudioFilterLvlText gAudioRange
  Gui, core:Add, UpDown, Range5-95 vAudioFilterLvl, 60
  }
Gui, core:Add, Text, xm+0, ;empty text for spacing
If system = ps1
  {
  Gui, core:Add, Text, xm+0 yp+10, Quick presets:
  Gui, core:Add, Button, xp-1 y+4 gcorePMaxS, Max Speed
  Gui, core:Add, Button, x+8 gcorePTurbo, Turbo
  Gui, core:Add, Button, x+8 gcorePFast, Fast
  Gui, core:Add, Button, x+8 gcorePSafe, Safe
  Gui, core:Add, Button, x+8 gcorePQuality, Quality
  }
Gui, core:Add, Button, xm-1 y+8 gcoreReset, Reset
Gui, core:Add, Button, x+8 yp gcoreCancel, Cancel
Gui, core:Add, Button, x+8 yp gcoreOK, OK
If system = ps1
  {
  Gui, core:Font, s7, MS Shell Dlg 2
  GuiControl, core:Font, ShowBiosT
  GuiControl, core:Font, SHSMCT
  GuiControl, core:Font, SHGTERegsT
  GuiControl, core:Font, SHGTEFlagsT
  GuiControl, core:Font, AsyncCDT
  }
coreoptionsguicreated = 1
coreoptionsOKpressed = 0
coreoptionsguiopen:
Gui, core:Show,, %Title% - Emulator Options
Gui, core:+Owner%mgui% -Sysmenu
Gui, %mgui%:+Disabled
Return

ClockRange:
GuiControlGet, PSXClockText, core:, PSXClockText
If system = ps1
  {
  If PSXClockText < 30
      GuiControl, core:, PSXClockText, 30
  If PSXClockText > 100
      GuiControl, core:, PSXClockText, 100
  }
If system = neogeo
  {
  If (PSXClockText < 100 || PSXClockText = 109)
      GuiControl, core:, PSXClockText, 100
  If (PSXClockText >= 101 && PSXClockText <= 108) || PSXClockText = 119
      GuiControl, core:, PSXClockText, 110
  If (PSXClockText >= 111 && PSXClockText <= 118) || PSXClockText = 129
      GuiControl, core:, PSXClockText, 120
  If (PSXClockText >= 121 && PSXClockText <= 128) || PSXClockText = 139
      GuiControl, core:, PSXClockText, 130
  If (PSXClockText >= 131 && PSXClockText <= 138) || PSXClockText = 149
      GuiControl, core:, PSXClockText, 140
  If (PSXClockText >= 141 && PSXClockText <= 148) || PSXClockText = 159
      GuiControl, core:, PSXClockText, 150
  If (PSXClockText >= 151 && PSXClockText <= 158) || PSXClockText = 169
      GuiControl, core:, PSXClockText, 160
  If (PSXClockText >= 161 && PSXClockText <= 168) || PSXClockText = 179
      GuiControl, core:, PSXClockText, 170
  If (PSXClockText >= 171 && PSXClockText <= 178) || PSXClockText = 189
      GuiControl, core:, PSXClockText, 180
  If (PSXClockText >= 181 && PSXClockText <= 188) || PSXClockText = 199
      GuiControl, core:, PSXClockText, 190
  If (PSXClockText >= 191 && PSXClockText <= 198) || PSXClockText > 200
      GuiControl, core:, PSXClockText, 200
  }
Return

AudioRange:
GuiControlGet, AudioFilterLvlText, core:, AudioFilterLvlText
If system = neogeo
  {
  If (AudioFilterLvlText < 5 || AudioFilterLvlText = 9)
      GuiControl, core:, AudioFilterLvlText, 5
  If (AudioFilterLvlText >= 6 && AudioFilterLvlText <= 8) || AudioFilterLvlText = 14
      GuiControl, core:, AudioFilterLvlText, 10
  If (AudioFilterLvlText >= 11 && AudioFilterLvlText <= 13) || AudioFilterLvlText = 19
      GuiControl, core:, AudioFilterLvlText, 15
  If (AudioFilterLvlText >= 16 && AudioFilterLvlText <= 18) || AudioFilterLvlText = 24
      GuiControl, core:, AudioFilterLvlText, 20
  If (AudioFilterLvlText >= 21 && AudioFilterLvlText <= 23) || AudioFilterLvlText = 29
      GuiControl, core:, AudioFilterLvlText, 25
  If (AudioFilterLvlText >= 26 && AudioFilterLvlText <= 28) || AudioFilterLvlText = 34
      GuiControl, core:, AudioFilterLvlText, 30
  If (AudioFilterLvlText >= 31 && AudioFilterLvlText <= 33) || AudioFilterLvlText = 39
      GuiControl, core:, AudioFilterLvlText, 35
  If (AudioFilterLvlText >= 36 && AudioFilterLvlText <= 38) || AudioFilterLvlText = 44
      GuiControl, core:, AudioFilterLvlText, 40
  If (AudioFilterLvlText >= 41 && AudioFilterLvlText <= 43) || AudioFilterLvlText = 49
      GuiControl, core:, AudioFilterLvlText, 45
  If (AudioFilterLvlText >= 46 && AudioFilterLvlText <= 48) || AudioFilterLvlText = 54
      GuiControl, core:, AudioFilterLvlText, 50
  If (AudioFilterLvlText >= 51 && AudioFilterLvlText <= 53) || AudioFilterLvlText = 59
      GuiControl, core:, AudioFilterLvlText, 55
  If (AudioFilterLvlText >= 56 && AudioFilterLvlText <= 58) || AudioFilterLvlText = 64
      GuiControl, core:, AudioFilterLvlText, 60
  If (AudioFilterLvlText >= 61 && AudioFilterLvlText <= 63) || AudioFilterLvlText = 69
      GuiControl, core:, AudioFilterLvlText, 65
  If (AudioFilterLvlText >= 66 && AudioFilterLvlText <= 68) || AudioFilterLvlText = 74
      GuiControl, core:, AudioFilterLvlText, 70
  If (AudioFilterLvlText >= 71 && AudioFilterLvlText <= 73) || AudioFilterLvlText = 79
      GuiControl, core:, AudioFilterLvlText, 75
  If (AudioFilterLvlText >= 76 && AudioFilterLvlText <= 78) || AudioFilterLvlText = 84
      GuiControl, core:, AudioFilterLvlText, 80
  If (AudioFilterLvlText >= 81 && AudioFilterLvlText <= 83) || AudioFilterLvlText = 89
      GuiControl, core:, AudioFilterLvlText, 85
  If (AudioFilterLvlText >= 86 && AudioFilterLvlText <= 88) || AudioFilterLvlText = 94
      GuiControl, core:, AudioFilterLvlText, 90
  If (AudioFilterLvlText >= 91 && AudioFilterLvlText <= 93) || AudioFilterLvlText > 95
      GuiControl, core:, AudioFilterLvlText, 95
  }
Return

corePMaxS:
GuiControl, core:, Vsync, 0
GuiControl, core:ChooseString, Frameskip, 1
GuiControl, core:, Dither, 0
GuiControl, core:, PSXClock, 30
GuiControl, core:, Audio, 0
GuiControl, core:ChooseString, SoundInter, off
GuiControl, core:, ThreadRend, 1
GuiControl, core:, UnaiBlend, 0
GuiControl, core:, UnaiLight, 0
GuiControl, core:, UnaiIlace, 1
GuiControl, core:, UnaiPixSkip, 1
GuiControl, core:, UnaiScaleHiRes, 1
GuiControl, core:, SHSMC, 1
GuiControl, core:, SHGTERegs, 1
GuiControl, core:, SHGTEFlags, 1
GuiControl, core:, AsyncCD, 1
Return

corePTurbo:
GuiControl, core:, Vsync, 0
GuiControl, core:ChooseString, Frameskip, 0
GuiControl, core:, Dither, 0
GuiControl, core:, PSXClock, 34
GuiControl, core:, Audio, 1
GuiControl, core:ChooseString, SoundInter, simple
GuiControl, core:, ThreadRend, 1
GuiControl, core:, UnaiBlend, 1
GuiControl, core:, UnaiLight, 0
GuiControl, core:, UnaiIlace, 0
GuiControl, core:, UnaiPixSkip, 0
GuiControl, core:, UnaiScaleHiRes, 1
GuiControl, core:, SHSMC, 0
GuiControl, core:, SHGTERegs, 1
GuiControl, core:, SHGTEFlags, 1
GuiControl, core:, AsyncCD, 1
Return

corePFast:
GuiControl, core:, Vsync, 0
GuiControl, core:ChooseString, Frameskip, 0
GuiControl, core:, Dither, 0
GuiControl, core:, PSXClock, 37
GuiControl, core:, Audio, 1
GuiControl, core:ChooseString, SoundInter, gaussian
GuiControl, core:, ThreadRend, 1
GuiControl, core:, UnaiBlend, 1
GuiControl, core:, UnaiLight, 1
GuiControl, core:, UnaiIlace, 0
GuiControl, core:, UnaiPixSkip, 0
GuiControl, core:, UnaiScaleHiRes, 1
GuiControl, core:, SHSMC, 0
GuiControl, core:, SHGTERegs, 1
GuiControl, core:, SHGTEFlags, 0
GuiControl, core:, AsyncCD, 1
Return

corePSafe:
GuiControl, core:, Vsync, 0
GuiControl, core:ChooseString, Frameskip, 0
GuiControl, core:, Dither, 0
GuiControl, core:, PSXClock, 40
GuiControl, core:, Audio, 1
GuiControl, core:ChooseString, SoundInter, gaussian
GuiControl, core:, ThreadRend, 1
GuiControl, core:, UnaiBlend, 1
GuiControl, core:, UnaiLight, 1
GuiControl, core:, UnaiIlace, 0
GuiControl, core:, UnaiPixSkip, 0
GuiControl, core:, UnaiScaleHiRes, 1
GuiControl, core:, SHSMC, 0
GuiControl, core:, SHGTERegs, 0
GuiControl, core:, SHGTEFlags, 0
GuiControl, core:, AsyncCD, 0
Return

corePQuality:
GuiControl, core:, Vsync, 1
GuiControl, core:ChooseString, Frameskip, 0
GuiControl, core:, Dither, 1
GuiControl, core:, PSXClock, 47
GuiControl, core:, Audio, 1
GuiControl, core:ChooseString, SoundInter, gaussian
GuiControl, core:, ThreadRend, 0
GuiControl, core:, UnaiBlend, 1
GuiControl, core:, UnaiLight, 1
GuiControl, core:, UnaiIlace, 0
GuiControl, core:, UnaiPixSkip, 0
GuiControl, core:, UnaiScaleHiRes, 0
GuiControl, core:, SHSMC, 0
GuiControl, core:, SHGTERegs, 0
GuiControl, core:, SHGTEFlags, 0
GuiControl, core:, AsyncCD, 0
Return

coreReset:
GuiControl, core:, Vsync, 1
GuiControl, core:ChooseString, TurboButton, None
GuiControl, core:, ShowTouch, 1
GuiControl, core:, Audio, 1
If system = ps1
  {
  GuiControl, core:, HLEbiosCheck, 0
  GuiControl, core:ChooseString, Frameskip, 0
  GuiControl, core:, Memcard2, 0
  GuiControl, core:ChooseString, Pad1, standard
  GuiControl, core:ChooseString, NegDZ, 0
  GuiControl, core:ChooseString, NegResp, linear
  GuiControl, core:, Dither, 0
  GuiControl, core:, PSXClock, 50
  GuiControl, core:ChooseString, SoundInter, gaussian
  GuiControl, core:, ShowBios, 0
  GuiControl, core:, FixDiablo, 0
  GuiControl, core:, FixPE2VH2, 0
  GuiControl, core:, FixInu, 0
  GuiControl, core:, ThreadRend, 1
  GuiControl, core:, UnaiBlend, 1
  GuiControl, core:, UnaiLight, 1
  GuiControl, core:, UnaiIlace, 0
  GuiControl, core:, UnaiPixSkip, 0
  GuiControl, core:, UnaiScaleHiRes, 0
  GuiControl, core:, SHSMC, 0
  GuiControl, core:, SHGTERegs, 0
  GuiControl, core:, SHGTEFlags, 0
  GuiControl, core:, AsyncCD, 0
  }
If system = neogeo
  {
  GuiControl, core:ChooseString, HLEbiosCheck, UNIBIOS
  GuiControl, core:ChooseString, Frameskip, disabled
  GuiControl, core:ChooseString, FrameskipThreshold, 33
  GuiControl, core:, PSXClock, 100
  GuiControl, core:, AudioFilter, 0
  GuiControl, core:, AudioFilterLvl, 60
  }
;GuiControl, core:, CpadDpad, 0



Return

coreOK:
coreoptionsOKpressed = 1
Gui, %mgui%:-Disabled
Gui, core:Submit
FileRead, coreoptions, tools\assets_%system%\retroarch-core-options.cfg
FileRead, rarchoptions, tools\assets_%system%\retroarch.cfg

MsgBox, % TurboButtonIndex()
If Vsync != 1
    StringReplace, rarchoptions, rarchoptions,video_vsync = "true",video_vsync = "false"
else
    StringReplace, rarchoptions, rarchoptions,audio_sync = "true",audio_sync = "false"
If (Frameskip != 0 || Frameskip != disabled)
    {
    If system = ps1
      StringReplace, coreoptions, coreoptions,pcsx_rearmed_frameskip = "0",pcsx_rearmed_frameskip = "%Frameskip%"
    If system = neogeo
      StringReplace, coreoptions, coreoptions,fbalpha2012_neogeo_frameskip = "disabled",fbalpha2012_neogeo_frameskip = "%Frameskip%"
    }
If FrameskipThreshold != 33
    StringReplace, coreoptions, coreoptions,fbalpha2012_neogeo_frameskip_threshold = "33",fbalpha2012_neogeo_frameskip_threshold = "%FrameskipThreshold%"
If Memcard2 != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_memcard2 = "disabled",pcsx_rearmed_memcard2 = "enabled"
If Pad1 != standard
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_pad1type = "standard",pcsx_rearmed_pad1type = "%Pad1%"
;If CpadDpad != 0
;    StringReplace, rarchoptions, rarchoptions,input_player1_analog_dpad_mode = "0",input_player1_analog_dpad_mode = "1"
If TurboButton != None
    StringReplace, rarchconfig, rarchconfig,input_player1_turbo_btn = "nul",input_player1_turbo_btn = "TurboButtonIndex()"
If NegDZ != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_negcon_deadzone = "0",pcsx_rearmed_negcon_deadzone = "%NegDZ%"
If NegResp != linear
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_negcon_response = "0",pcsx_rearmed_negcon_response = "%NegResp%"
If Dither != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_dithering = "disabled",pcsx_rearmed_dithering = "enabled"
If system = ps1
  If PSXClock != 50
      StringReplace, coreoptions, coreoptions,pcsx_rearmed_psxclock = "50",pcsx_rearmed_psxclock = "%PSXClock%"
If system = neogeo
  If PSXClock != 100
      StringReplace, coreoptions, coreoptions,fbalpha2012_neogeo_cpu_speed_adjust = "100",fbalpha2012_neogeo_cpu_speed_adjust = "%PSXClock%"
If Audio != 1
    StringReplace, rarchoptions, rarchoptions,audio_enable = "true",audio_enable = "false"
If SoundInter != gaussian
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_spu_interpolation = "gaussian",pcsx_rearmed_spu_interpolation = "%SoundInter%"
If system = neogeo
  {
  If AudioFilter != 0
      StringReplace, coreoptions, coreoptions,fbalpha2012_neogeo_lowpass_filter = "disabled",fbalpha2012_neogeo_lowpass_filter = "enabled"
  If AudioFilterLvl != 60
      StringReplace, coreoptions, coreoptions,fbalpha2012_neogeo_lowpass_range = "60",fbalpha2012_neogeo_lowpass_range = "%AudioFilterLvl%"
  }
If ShowBios != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_show_bios_bootlogo = "disabled",pcsx_rearmed_show_bios_bootlogo = "enabled"
If FixDiablo != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_idiablofix = "disabled",pcsx_rearmed_idiablofix = "enabled"
If FixPE2VH2 != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_pe2fix = "disabled",pcsx_rearmed_pe2fix = "enabled"
If FixInu != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_inuyasha_fix = "disabled",pcsx_rearmed_inuyasha_fix = "enabled"
If ThreadRend != 1
    StringReplace, coreoptions, coreoptions, pcsx_rearmed_gpu_thread_rendering = "enabled", pcsx_rearmed_gpu_thread_rendering = "disabled"
If UnaiBlend != 1
    StringReplace, coreoptions, coreoptions, pcsx_rearmed_gpu_unai_blending = "enabled", pcsx_rearmed_gpu_unai_blending = "disabled"
If UnaiLight != 1
    StringReplace, coreoptions, coreoptions, pcsx_rearmed_gpu_unai_lighting = "enabled", pcsx_rearmed_gpu_unai_lighting = "disabled"
If UnaiIlace != 0
    StringReplace, coreoptions, coreoptions, pcsx_rearmed_gpu_unai_ilace_force = "disabled", pcsx_rearmed_gpu_unai_ilace_force = "enabled"
If UnaiPixSkip != 0
    StringReplace, coreoptions, coreoptions, pcsx_rearmed_gpu_unai_pixel_skip = "disabled", pcsx_rearmed_gpu_unai_pixel_skip = "enabled"
If UnaiScaleHiRes != 0
    StringReplace, coreoptions, coreoptions, pcsx_rearmed_gpu_unai_scale_hires = "disabled", pcsx_rearmed_gpu_unai_scale_hires = "enabled"
If SHSMC != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_nosmccheck = "disabled",pcsx_rearmed_nosmccheck = "enabled"
If SHGTERegs != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_gteregsunneeded = "disabled",pcsx_rearmed_gteregsunneeded = "enabled"
If SHGTEFlags != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_nogteflags = "disabled",pcsx_rearmed_nogteflags = "enabled"
If AsyncCD != 0
    StringReplace, coreoptions, coreoptions,pcsx_rearmed_async_cd = "sync",pcsx_rearmed_async_cd = "async"
Return

coreGuiEscape:
coreCancel:
Gui, %mgui%:-Disabled
Gui, core:Cancel
If coreoptionsOKpressed = 1
    {
    GuiControl, core:, Vsync, %Vsync%
    GuiControl, core:ChooseString, Frameskip, %Frameskip%
    GuiControl, core:, ShowTouch, %ShowTouch%
    GuiControl, core:, PSXClock, %PSXClock%
    GuiControl, core:, Audio, %Audio%
    If system = ps1
      {
      GuiControl, core:, HLEbiosCheck, %HLEbiosCheck%
      GuiControl, core:, Memcard2, %Memcard2%
      GuiControl, core:ChooseString, Pad1, %Pad1%
      GuiControl, core:ChooseString, NegDZ, %NegCon%
      GuiControl, core:ChooseString, NegResp, %NegResp%
      GuiControl, core:, Dither, %Dither%
      GuiControl, core:ChooseString, SoundInter, %SoundInter%
      GuiControl, core:, ShowBios, %ShowBios%
      GuiControl, core:, FixDiablo, %FixDiablo%
      GuiControl, core:, FixPE2VH2, %FixPE2VH2%
      GuiControl, core:, FixInu, %FixInu%
      GuiControl, core:, ThreadRend, %ThreadRend%
      GuiControl, core:, UnaiBlend, %UnaiBlend%
      GuiControl, core:, UnaiLight, %UnaiLight%
      GuiControl, core:, UnaiIlace, %UnaiIlace%
      GuiControl, core:, UnaiPixSkip, %UnaiPixSkip%
      GuiControl, core:, SHSMC, %SHSMC%
      GuiControl, core:, SHGTERegs, %SHGTERegs%
      GuiControl, core:, SHGTEFlags, %SHGTEFlags%
      GuiControl, core:, AsyncCD, %AsyncCD%
      }
    If system = neogeo
      {
      GuiControl, core:ChooseString, HLEbiosCheck, %HLEbiosCheck%
      GuiControl, core:ChooseString, FrameskipThreshold, %FrameskipThreshold%
      GuiControl, core:, AudioFilter, %AudioFilter%
      GuiControl, core:, AudioFilterLvl, %AudioFilterLvl%
      }
    ;GuiControl, core:, CpadDpad, %CpadDpad%
    }
Else
    Gosub, coreReset

TurboButtonIndex()
    {
    Global TurboButton

    If TurboButton = N3DS A
        Return, 8
    If TurboButton = N3DS B
        Return, 0
    If TurboButton = N3DS X
        Return, 9
    If TurboButton = N3DS Y
        Return, 1
    If TurboButton = N3DS L
        Return, 10
    If TurboButton = N3DS R
        Return, 11
    If TurboButton = N3DS ZL
        Return, 12
    If TurboButton = N3DS ZR
        Return, 13
    If TurboButton = N3DS Left Touch
        Return, 14
    If TurboButton = N3DS Right Touch
        Return, 15
    If TurboButton = None
        Return, "nul"
    }