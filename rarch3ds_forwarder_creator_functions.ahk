global system
global coreoptionsOKpressed
global fileext

randomproductcode()
    {
    characters = ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890
    Random, rng1, 1, 36
    Random, rng2, 1, 36
    Random, rng3, 1, 36
    Random, rng4, 1, 36
    StringMid, rpc1, characters, %rng1%, 1
    StringMid, rpc2, characters, %rng2%, 1
    StringMid, rpc3, characters, %rng3%, 1
    StringMid, rpc4, characters, %rng4%, 1
    rpc := rpc1 . rpc2 . rpc3 . rpc4
    Return, rpc
    }

randomuniqueid()
    {
    characters = ABCDEF1234567890
    Random, rng1, 1, 16
    Random, rng2, 1, 16
    Random, rng3, 1, 16
    Random, rng4, 1, 16
    StringMid, ruid1, characters, %rng1%, 1
    StringMid, ruid2, characters, %rng2%, 1
    StringMid, ruid3, characters, %rng3%, 1
    StringMid, ruid4, characters, %rng4%, 1
    ruid := ruid1 . ruid2 . ruid3 . ruid4
    Return, ruid
    }

createcodebin(rom)
    {
    Global ps1seek
    FileCreateDir, tools\exefs
    FileCopy, tools\assets_%system%\code.bin, tools\exefs, 1
    If ErrorLevel > 0
        {
        FileRemoveDir, tools\exefs, 1
        Return, 0
        }
    If system = gba
        Return, 1
    romnamelen := StrLen(rom)
    codebin := FileOpen("tools\exefs\code.bin","a")
    If system = neogeo
        codebin.Seek(0x1eb853) ;before was 0x1ebadf
    If system = cps1
        codebin.Seek(0x1d95eb)
    If system = cps2
        codebin.Seek(0x1acafb)
    If system = ps1
        {
        If fileext = pbp
            Return, 1
        codebin.Seek(ps1seek)
        StrPutEx(fileext,fileextraw,"UTF-8")
        codebin.RawWrite(fileextraw,3)
        codebin.Close()
        Return, 1
        }
    StrPutEx(rom,romraw,"UTF-8")
    Hex2Bin(NULL,"00000000000000")
    codebin.RawWrite(romraw,romnamelen)
    If romnamelen < 13
        codebin.RawWrite(NULL,13-romnamelen)
    codebin.Close()
    Return, 1
    }

createretroconfig(uniqueid)
    {
    global rarchoptions

    FileCreateDir, tools\romfs
    If coreoptionsOKpressed = 1
        {
        FileAppend, %rarchoptions%, tools\romfs\retroarch.cfg, UTF-8
        retroarchcfgR := FileOpen("tools\romfs\retroarch.cfg","r")
        }
    Else
        retroarchcfgR := FileOpen("tools\assets_" . system . "\retroarch.cfg","r")
    If retroarchcfgR = 0
        {
        FileRemoveDir, tools\romfs, 1
        Return, 0
        }
    retroarchcfgR := retroarchcfgR.Read()
    retroarchcfgR.Close()
    retroarchcfgR := StrReplace(retroarchcfgR,"ABCD",uniqueid)
    retroarchcfgW := FileOpen("tools\romfs\retroarch.cfg","w")
    If retroarchcfgW = 0
        {
        FileRemoveDir, tools\romfs, 1
        Return, 0
        }
    retroarchcfgW.Write(retroarchcfgR)
    retroarchcfgW.Close()
    pathtxt := FileOpen("tools\romfs\path.txt","w")
    pathtxt.Write(uniqueid)
    pathtxt.Close()
    Return, 1
    }

createbanner(longname,shortname,publisher,banner,sound)
    {
    global banner_size

    If banner =
        banner = none
    FileCreateDir, tools\banner
    RunWait, tools\convert.exe -scale %banner_size%! "%banner%" -size 256x128 tools\assets_%system%\banner_border.png +swap -gravity center -composite tools\banner\banner.png,, Hide
    If ErrorLevel = 1
        FileCopy, tools\assets_%system%\banner_border.png, tools\banner\banner.png, 1
    RunWait, tools\bannertool.exe makebanner -i tools\banner\banner.png -a "%sound%" -o tools\exefs\banner.bnr,, Hide
    If !FileExist("tools\exefs\banner.bnr")
        {
        FileRemoveDir, tools\banner, 1
        Return, 0
        }
    RunWait, tools\convert.exe -scale 40x40 "%banner%" -size 48x48 tools\assets_%system%\icon_border.png +swap -gravity center -composite tools\banner\icon.png,, Hide
    If ErrorLevel = 1
        FileCopy, tools\assets_%system%\icon_border.png, tools\banner\icon.png, 1
    If system = ps1
        RunWait, tools\bannertool.exe makesmdh -s "%shortname%" -l "%longname%" -p "%publisher%" -f visible`,allow3d`,recordusage`,nosavebackups`,new3ds -i tools\banner\icon.png -o tools\exefs\icon.icn,, Hide
    Else
        RunWait, tools\bannertool.exe makesmdh -s "%shortname%" -l "%longname%" -p "%publisher%" -f visible`,allow3d`,recordusage`,nosavebackups -i tools\banner\icon.png -o tools\exefs\icon.icn,, Hide
    If !FileExist("tools\exefs\icon.icn")
        {
        FileRemoveDir, tools\banner, 1
        Return, 0
        }
    FileRemoveDir, tools\banner, 1
    Return, 1
    }

buildexefs()
    {
    If !FileExist("tools\exefs")
        FileCreateDir, tools\exefs
    FileCopy, tools\assets_%system%\logolz.bin, tools\exefs\logo.darc.lz
        If ErrorLevel > 0
            {
            FileRemoveDir, tools\exefs, 1
            Return, 0
            }
    RunWait, tools\3dstool.exe -ctf exefs tools\exefs.bin --exefs-dir tools\exefs --header tools\assets_%system%\headerexefs.bin,, Hide
    If ErrorLevel = 1
        {
        FileRemoveDir, tools\exefs, 1
        FileRemoveDir, tools\romfs, 1
        FileDelete, tools\exefs.bin
        Return, 0
        }
    FileRemoveDir, tools\exefs, 1
    If !FileExist("tools\exefs.bin")
        {
        FileRemoveDir, tools\exefs, 1
        FileRemoveDir, tools\romfs, 1
        FileDelete, tools\exefs.bin
        Return, 0
        }
    Return, 1
    }

buildromfs(bios,rom,rom2="",unibios=0)
    {
    global coreoptions
    global ShowTouch
    global romname
    global romdir

    If system = neogeo
	    {
        If unibios = 1
            {
            FileRead, coreoptions, tools\assets_%system%\retroarch-core-options.cfg
            StringReplace, coreoptions, coreoptions,fba-unibios = "disabled",fba-unibios = "enabled"
            FileAppend, %coreoptions%, tools\romfs\retroarch-core-options.cfg, UTF-8
            }
        }
    Else If system != ps1
        FileCopy, tools\assets_%system%\retroarch-core-options.cfg, tools\romfs\retroarch-core-options.cfg
    If system != ps1
        FileCopy, %bios%, tools\romfs
    If system = gba
        FileCopy, %rom%, tools\romfs\rom.gba
    Else If system = ps1
        {
        If coreoptionsOKpressed = 0
            FileRead, coreoptions, tools\assets_%system%\retroarch-core-options.cfg
        If unibios = 1
            StringReplace, coreoptions, coreoptions,pcsx_rearmed_bios = "auto",pcsx_rearmed_bios = "hle"
        Else
            {
            StringReplace, coreoptions, coreoptions,pcsx_rearmed_bios = "hle",pcsx_rearmed_bios = "auto"
            Loop, Parse, bios, |
                {
                If (FileExist(A_LoopField))
                    {
                    FileCopy, %A_LoopField%, tools\romfs
                    Break
                    }
                }
            }
        FileAppend, %coreoptions%, tools\romfs\retroarch-core-options.cfg, UTF-8
        FileCopy, %romdir%\%romname%.%fileext%, % "tools\romfs\game." Format("{:L}", fileext)
        If rom2 = Single
            {
            If FileExist(romdir "\" romname ".sbi")
                FileCopy, %romdir%\%romname%.sbi, tools\romfs\game.sbi
            }
        If rom2 = Multi
            {
            Loop, 5
                {
                If FileExist(romdir "\" romname "_" A_Index ".sbi")
                    FileCopy, %romdir%\%romname%_%A_Index%.sbi, tools\romfs\game_%A_Index%.sbi
                }
            }
        }
    Else
        FileCopy, %rom%, tools\romfs
    If (rom2 != "" && system != "ps1")
        If rom2 != %rom%
            FileCopy, %rom2%, tools\romfs
    If ShowTouch = 1
        FileCopy, tools\assets_%system%\bottom.bin, tools\romfs
    RunWait, tools\3dstool.exe -ctf romfs tools\romfs.bin --romfs-dir tools\romfs,, Hide
    If ErrorLevel = 1
        {
        FileRemoveDir, tools\romfs, 1
        FileDelete, tools\romfs.bin
        Return, 0
        }
    FileRemoveDir, tools\romfs, 1
    If !FileExist("tools\romfs.bin")
        Return, 0
    Return, 1
    }

buildcia(productcode,uniqueid,cianame)
    {
    FileCreateDir, tools\headers
    FileCopy, tools\assets_%system%\headerncch0.bin, tools\headers, 1
        If ErrorLevel > 0
            {
            FileRemoveDir, tools\headers, 1
            Return, 0
            }
    uniqueidinv := SubStr(uniqueid,3,2) . SubStr(uniqueid,1,2)
    Hex2Bin(uniqueidraw,uniqueidinv)
    StrPutEx(productcode,productcoderaw,"UTF-8")
    headerncch0bin := FileOpen("tools\headers\headerncch0.bin","a")
        If headerncch0bin = 0
            {
            FileRemoveDir, tools\headers, 1
            Return, 0
            }
    headerncch0bin.Seek(0x109)
    headerncch0bin := headerncch0bin.RawWrite(uniqueidraw,2)
    headerncch0bin := FileOpen("tools\headers\headerncch0.bin","a")
        If headerncch0bin = 0
            {
            FileRemoveDir, tools\headers, 1
            Return, 0
            }
    headerncch0bin.Seek(0x119)
    headerncch0bin := headerncch0bin.RawWrite(uniqueidraw,2)
    headerncch0bin := FileOpen("tools\headers\headerncch0.bin","a")
        If headerncch0bin = 0
            {
            FileRemoveDir, tools\headers, 1
            Return, 0
            }
    headerncch0bin.Seek(0x156)
    headerncch0bin := headerncch0bin.RawWrite(productcoderaw,4)
    headerncch0bin.Close()

    FileCopy, tools\assets_%system%\exheader.bin, tools\headers, 1
        If ErrorLevel > 0
            {
            FileRemoveDir, tools\headers, 1
            Return, 0
            }
    exheaderbin := FileOpen("tools\headers\exheader.bin","a")
        If exheaderbin = 0
            {
            FileRemoveDir, tools\headers, 1
            Return, 0
            }
    exheaderbin.Seek(0x1c9)
    exheaderbin := exheaderbin.RawWrite(uniqueidraw,2)
    exheaderbin := FileOpen("tools\headers\exheader.bin","a")
        If exheaderbin = 0
            {
            FileRemoveDir, tools\headers, 1
            Return, 0
            }
    exheaderbin.Seek(0x201)
    exheaderbin := exheaderbin.RawWrite(uniqueidraw,2)
    exheaderbin := FileOpen("tools\headers\exheader.bin","a")
        If exheaderbin = 0
            {
            FileRemoveDir, tools\headers, 1
            Return, 0
            }
    exheaderbin.Seek(0x601)
    exheaderbin := exheaderbin.RawWrite(uniqueidraw,2)
    exheaderbin.Close()

    RunWait, tools\3dstool.exe -ctf cxi tools\cxi.bin --header tools\headers\headerncch0.bin --exh tools\headers\exheader.bin --exefs tools\exefs.bin --romfs tools\romfs.bin --logo tools\assets_%system%\logolz.bin,, Hide
    If ErrorLevel = 1
        {
        FileDelete, tools\*.bin
        Return, 0
        }
    FileRemoveDir, tools\headers, 1
    FileDelete, tools\exefs.bin
    FileDelete, tools\romfs.bin
    RunWait, tools\makerom.exe -f cia -content tools\cxi.bin:0:0x00 -o "%cianame%",, Hide
    If ErrorLevel = 1
        {
        FileDelete, tools\*.bin
        Return, 0
        }
    FileDelete, tools\cxi.bin
    If !FileExist(cianame)
        Return, 0
    Return, 1
    }

;Other Functions
StrPutEx(str, ByRef VarOrAddress, enc)
{
	if (IsVar := IsByRef(VarOrAddress))
		VarSetCapacity(VarOrAddress, StrPut(str, enc) * ((enc="UTF-16"||enc="CP1200") ? 2 : 1))
	if ((addr := IsVar ? &VarOrAddress : VarOrAddress)+0 != "")
		return StrPut(str, addr, enc)
}

Hex2Bin(ByRef @bin, _hex, _byteNb=0)
{
	local dataSize, granted, dataAddress, x

	; Get size of data
	x := StrLen(_hex)
	dataSize := Ceil(x / 2)
	if (x = 0 or dataSize * 2 != x)
	{
		; Invalid string, empty or odd number of digits
		ErrorLevel = Param
		Return -1
	}
	If (_byteNb < 1 or _byteNb > dataSize)
	{
		_byteNb := dataSize
	}
	; Make enough room
	granted := VarSetCapacity(@bin, _byteNb, 0)
	if (granted < _byteNb)
	{
		; Cannot allocate enough memory
		ErrorLevel = Mem=%granted%
		Return -1
	}
	dataAddress := &@bin

	Loop Parse, _hex
	{
		if (A_Index & 1)	; Odd
		{
			x = %A_LoopField%	; Odd digit
		}
		else
		{
			; Concatenate previous x and even digit, converted to hex
			x := "0x" . x . A_LoopField
			; Store integer in memory
			DllCall("RtlFillMemory"
					, "UInt", dataAddress
					, "UInt", 1
					, "UChar", x)
			dataAddress++
		}
	}

	Return _byteNb
}
