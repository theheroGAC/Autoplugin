--[[ 
	Autoinstall plugin

	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Dev: TheHeroGAC
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

--Here more plugins!!!!
plugins = {

--Kernel
{ name = "NoNpDrm by TheOfficialFloW v1.2", path = "nonpdrm.skprx", section = "KERNEL", path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_NONPDRM"], },
{ name = "NoNpDrm Unofficial by LMAN v1.4", path = "nonpdrm_un.skprx", section = "KERNEL", path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_NONPDRMU"], },
{ name = "NoPsmDrm by frangarcj v1.4", path = "nopsmdrm.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_NOPSMDRM"], },
{ name = "Vitabright by devnoname120 v1.0", path = "vitabright.skprx", section = "KERNEL",  path2 = false, section2 = false, config = "vitabright_lut.txt", version = "0001", desc = LANGUAGE["INSTALLP_DESC_VITABRIGHT"], },
{ name = "NoAVLS by SilicaAndPina", path = "noavls.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_NOAVLS"], },
{ name = "Repatch by dots-tb v3.0", path = "repatch.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_REPATCH"], },
{ name = "Repatch by dots-tb v2.71", path = "repatch_4.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_REPATCH271"], },
{ name = "LOLIcon by dots-tb v1.0.1.1 HOTFIX A", path = "lolicon.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_LOLICON"], },
{ name = "ds3vita by xerpi Beta3", path = "ds3vita.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_DS3VITA"], },
{ name = "ds4vita by xerpi v1.2", path = "ds4vita.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_DS4VITA"], },
{ name = "udcd_uvc by xerpi v1.4", path = "udcd_uvc.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_UDCDUVC"], },
{ name = "udcd_uvc OLED by xerpi v1.4", path = "udcd_uvc_oled_off.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_UDCDUVCO"], },
{ name = "udcd_uvc LCD by xerpi v1.4", path = "udcd_uvc_lcd_off.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_UDCDUVCL"], },
{ name = "vitastick by xerpi v0.4.1 alpha", path = "vitastick.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_VITASTICK"], },
{ name = "viimote by xerpi v1.2", path = "viimote.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_VIIMOTE"], },
{ name = "Adrenaline by TheOfficialFloW (Fix double touch)", path = "adrenaline_kernel.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_ADRENALINE"], },
{ name = "DSMotion by OperationNT414C v1.2", path = "dsmotion.skprx", section = "KERNEL",  path2 = "dsmotion.suprx", section2 = "ALL", config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_DSMOTION"], },
{ name = "usbmc by yifanlu v6 (only for PSTV)", path = "usbmc.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_USBMC"], },
{ name = "AnalogsEnhancer by Rinnegatamante/Yoti v1.1-ur0", path = "AnalogsEnhancer.skprx", section = "KERNEL",  path2 = false, section2 = false, config = "AnaEnCfg.txt", configpath = "ur0:tai/", version = "0001", desc = LANGUAGE["INSTALLP_DESC_ANALOGSENHANCER"], },
{ name = "ioplus by dots-tb v0.1", path = "ioplus.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_IOPLUS"], },
{ name = "Vitacheat Z05 BETA by r0ah FOR 3.65+", path = "vitacheat.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_VITACHEAT"], },
{ name = "Vitacheat Z05 BETA FOR 3.60", path = "vitacheat360.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_VITACHEAT2"], },
{ name = "AnalogStickDisable by Hack-Usagi v1.1", path = "AnalogStickDisable.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_ANALOGSTICK"], },
{ name = "AnalogStickDisable Left To Right by Yoti v1.2", path = "AnalogStickDisable_LeftToRight.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_ANALOGSTICK1"], },
{ name = "AnalogStickDisable Right To Left by Yoti v1.2", path = "AnalogStickDisable_RightToLeft.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_ANALOGSTICK2"], },
{ name = "AnalogStickDisable Swap Left To Right by Yoti v1.2", path = "AnalogStickDisable_SwapLeftAndRight.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_ANALOGSTICK3"], },
{ name = "AnalogStickDisable Left Only by Hack-Usagi v1.1", path = "AnalogStickDisable_LeftOnly.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_ANALOGSTICK4"], },
{ name = "AnalogStickDisable Right Only by Hack-Usagi v1.1", path = "AnalogStickDisable_RightOnly.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_ANALOGSTICK5"], },
{ name = "cidSpoofer by SilicaAndPina v1.0", path = "cidSpoof.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_CIDSPOOF"], },
{ name = "reF00D by FAPS Team v1.0", path = "reF00D.skprx", section = "KERNEL",  path2 = false, section2 = false, config = "keys.bin", version = "0001", desc = LANGUAGE["INSTALLP_DESC_REFOOD"], },
{ name = "noled by reprep v1.1", path = "noled.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_NOLED"], },
{ name = "nosleep by NamelessGhoul0 v1.1", path = "nosleep.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_NOSLEEP"], },
{ name = "PSP2-batteryFixer by SKGleba v1.1", path = "bicr.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_BATFIX"], },
{ name = "VideoDebug by SilicaAndPina v1.0", path = "videoDebug.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_VIDEODBG"], },
{ name = "NoPowerLimits by Electry v1.1", path = "NoPowerLimits.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_NOPOWERL"], },
{ name = "DerInClocKS by teakhanirons v1.0", path = "derinclocks.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_DERIN"], },
{ name = "lolita500 by teakhanirons v1.0", path = "lolita500.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_LOLITA"], },
{ name = "lolita444 by teakhanirons v0.5", path = "lolita444.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_LOLITA4"], },
{ name = "PSVshell by Electry v1.1", path = "PSVshell.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_PSVSHELL"], },
{ name = "0syscall6 by SKGleba v1.2", path = "0syscall6.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_SYSCALL6"], },
{ name = "Monaural by cuevavirus v1.0.0", path = "monaural.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_MONAURAL"], },
{ name = "Music Premium by cuevavirus v1.0.4", path = "music_premium.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_MUPREMIUM"], },

--Boot_config.txt
{ name = "Custom Boot Splash by Princess of Sleeping", path = "custom_boot_splash.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_CUSTOMBOOTSPLASH"], },

--Main
{ name = "Download Enabler v5 by TheOfficialFloW (VitaTweaks)", path = "download_enabler.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_DENABLER"], },
{ name = "NoLockScreen v2 by TheOfficialFloW (VitaTweaks)", path = "nolockscreen.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_NOLOCKSCREEN"], },
{ name = "NoTrophyMsg by TheOfficialFloW (VitaTweaks)", path = "notrophymsg.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_NOTROPHYMSG"], },
{ name = "Custom Warning v2 by TheOfficialFloW (VitaTweaks)", path = "custom_warning.suprx", section = "main",  path2 = false, section2 = false, config = "custom_warning.txt", version = "0001", desc = LANGUAGE["INSTALLP_DESC_CUSTOMWARNING"], },

{ name = "Shellbat by nowrep vr10", path = "shellbat.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_SHELLBAT"], },
{ name = "Shellbat Mod by devnoname120 vr10", path = "shellbat_mod.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_SHELLBATM"], },
{ name = "Shellsecbat by OperationNT414C v10", path = "shellsecbat.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_SHELLSECBAT"], },
{ name = "pngshot by xyzz v1.3", path = "pngshot.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_PNGSHOT"], },
{ name = "Vflux by Applelo v0.5", path = "vflux.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_VFLUX"], },
{ name = "reSkype by SilicaAndPina v1.0", path = "reSkype.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_RESKYPE"], },
{ name = "Autoboot by Rinnegatamante v1.2 (only for 3.60/3.65)", path = "AutoBoot.suprx", section = "main",  path2 = false, section2 = false, config = false, configpath = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_AUTOBOOT"], },
{ name = "Vitacompanion by devnoname120 v1.00", path = "vitacompanion.suprx", section = "main",  path2 = false, section2 = false, config = false, configpath = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_VITACOMPA"], },
{ name = "volume_profile by cuevavirus v2.0.0", path = "jav.suprx", section = "main",  path2 = false, section2 = false, config = false, configpath = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_VOLUPROF"], },
{ name = "DolcePolce by SilicaAndPina v1.0", path = "DolcePolce.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_DOLCEPOLCE"], },
{ name = "LowMemMode by GrapheneCt v1.0", path = "LowMemMode.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_LOWMEMMODE"], },
{ name = "Quick Power by cuevavirus v1.0.0", path = "quick_power.suprx", section = "main",  path2 = false, section2 = false, config = false, configpath = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_QUICKPOWER"], },
{ name = "Quick Volume by cuevavirus v1.1.0", path = "quick_volume.suprx", section = "main",  path2 = false, section2 = false, config = false, configpath = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_QUICKVOLUME"], },
{ name = "QAscreenshot by GrapheneCt v1.1", path = "QAscreenshot.suprx", section = "main",  path2 = false, section2 = false, config = false, configpath = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_QASCREEN"], },

--All
{ name = "PSV-VSH MENU by joel16 v3.4", path = "vsh.suprx", section = "ALL",  path2 = "kuio.skprx", section2 = "KERNEL", config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_VSHMENU"], },-- Need kuio.skprx
{ name = "VitaGrafix by Electry v5.0.2", path = "VitaGrafix.suprx", section = "ALL",  path2 = "ioplus.skprx", section2 = "KERNEL", config = false, configpath = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_VITAGRAFIX"], },-- Need kuio.skprx
{ name = "Oclock Vita by frangarcj v1.2.1", path = "oclockvita.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_OVERCLOCK"], },
{ name = "Framecounter by Rinnegatamante v1.2", path = "Framecounter.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_FRAMECOUNTER"], },
{ name = "VGi by Electry v0.7", path = "VGi.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_VGI"], },
{ name = "FuckPSSE by SilicaAndPina v1.1", path = "FuckPSSE.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_FUCKPSSE"], },
{ name = "PSMPatch by SilicaAndPina v1.1", path = "PSMPatch.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_PSMPATCH"], },
{ name = "TropHAX by SilicaAndPina v2.0", path = "trophax2.0.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_TROPHAX"], },
{ name = "TurboPad by Rinnegatamante v0.3", path = "TurboPad.suprx", section = "ALL",  path2 = "kuio.skprx", section2 = "KERNEL", config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_TURBOPAD"], },
{ name = "reRescaler by Rinnegatamante v1.0", path = "reRescaler.suprx", section = "ALL",  path2 = "ioplus.skprx", section2 = "KERNEL", config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_RESCALER"], },
{ name = "InfiniteNet by Rinnegatamante v1.0", path = "InfiniteNet.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_INFINITENET"], },
{ name = "FreePSM by SilicaAndPina v1.1", path = "FreePSM.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_FREEPSM"], },
{ name = "MakePsmGreatAgain by SilicaAndPina v1.4", path = "MakePsmGreatAgain.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_MAKEPSM"], },
{ name = "WDNR by Rinnegatamante v1.0", path = "WDNR.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_WDNR"], },
{ name = "WDNF by EchoDev & Rinnegatamante v1.0", path = "WDNF.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_WDNF"], },
{ name = "remaPSV by Rinnegatamante v1.1", path = "remaPSV.suprx", section = "ALL",  path2 = "ioplus.skprx", section2 = "KERNEL", config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_REMAPSV"], },
{ name = "forcelang by xdanieldzd v0.2U", path = "forcelang.suprx", section = "ALL",  path2 = "ioplus.skprx", section2 = "KERNEL", config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_FORCELANG"], },
{ name = "ShowInfo Lite by Yoti v0.2", path = "ShowInfoLite.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_SHOWINFO"], },
{ name = "ShowInfo Full by Yoti v0.6", path = "ShowInfo.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_SHOWINFOFU"], },
{ name = "Volume Control Pack by GrapheneCt v1.0", path = "ModalVol.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_MODALVOL"], },

--*NPXS10013
{ name = "vita-ps4linkcontrols r7 by nowrep", path = "ps4linkcontrols.suprx", section = "NPXS10013",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_PS4LINK"], },

--NPXS10015 and *NPXS10016
{ name = "vita-macspoofer by Freakler", path = "macspoofer.suprx", section = "NPXS10015",  path2 = "macspoofer.suprx", section2 = "NPXS10016", config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_MACSPOOF"], },

--NPXS10036
{ name = "reScreeny by dots_tb v1.0", path = "reScreeny.suprx", section = "NPXS10036",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_RESCREENY"], },


}

if #plugins > 0 then table.sort(plugins, function (a,b) return string.lower(a.name)<string.lower(b.name) end) end
