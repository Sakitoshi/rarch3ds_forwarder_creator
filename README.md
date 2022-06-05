# rarch3ds_forwarder_creator
 Standalone Retroarch CIA Creator for 3DS

Simple GUI to create Retroarch CIA's all written in AHK 1.1

## How to update emulator cores (using pcsx_rearmed as an example)
1. set up devkitpro.
2. grab _devkitARM r45_ and _aemstro_.
3. grab [ctrulib_1.1_mod](https://github.com/Sakitoshi/ctrulib_1.1_mod).
4. grab [Retroarch-3DS-Forwarders-PSOne](https://github.com/Sakitoshi/RetroArch-3DS-Forwarders-PSOne).
5. grab _pcsx_rearmed_ from the libretro repositories.
6. grab [HackingToolkit3DS v9](https://github.com/Asia81/HackingToolkit9DS-Deprecated-/releases/tag/9).
7. follow [core compilation notes.txt](https://raw.githubusercontent.com/Sakitoshi/rarch3ds_forwarder_creator/master/core%20compilation%20notes.txt) instructions and compile _pcsx_rearmed_ to create _pcsx_rearmed_libretro_ctr.a_ and rename it _libretro_ctr.a_.
8. move _libretro_ctr.a_ to _RetroArch-3DS-Forwarders-PSOne_.
9. compile _RetroArch-3DS-Forwarders-PSOne_ to create _retroarch_3ds.cia_.
10. extract _retroarch_3ds.cia_ with _Hackingtoolkit3DS_.
11. go to _rarch3ds_forwarder_creator\tools\assets_ps1_ and replace _code.bin_, _exheader.bin_, _headerexefs.bin_ and _headerncch0.bin_ with the previously extracted files.
12. open _code.bin_ with an hex editor and find _romfs:/game.pbp_, note down the address for the first _p_ on _pbp_.
13. open the _version_ file with an hex editor and modify address 0x10 with the previously noted address. it needs to be written in little-endian (example: 003066D4 becomes D4663000).
14. (optional) while inside the _version_ file, update the emulator core version at address 0x0. it needs to be written in little-endian (example: 04BC5E35 becomes 355EBC04).
15. emulator core should be updated now.
