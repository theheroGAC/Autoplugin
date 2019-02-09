--Here more plugins!!!!
plugins = {

--Kernel
{ name = "NoNpDrm by TheOfficialFloW", path = "nonpdrm.skprx", section = "KERNEL", path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_NONPDRM"], },
--{ name = "MiniVitaTV by TheOfficialFloW vbeta0.2", path = "minivitatv.skprx", section = "KERNEL",  path2 = "ds3.skprx", section2 = "KERNEL", config = false, desc = LANGUAGE["INSTALLP_DESC_MINIVITATV"], },
{ name = "NoPsmDrm by frangarcj v1.4", path = "nopsmdrm.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_NOPSMDRM"], },
{ name = "Vitabright by devnoname120(only for 3.60/H-Encore 3.68)", path = "vitabright.skprx", section = "KERNEL",  path2 = false, section2 = false, config = "vitabright_lut.txt", version = "0001", desc = LANGUAGE["INSTALLP_DESC_VITABRIGHT"], },
{ name = "NoAVLS by SilicaAndPina", path = "noavls.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_NOAVLS"], },
{ name = "Repatch by dots-tb v3.0", path = "repatch.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_REPATCH"], },
{ name = "LOLIcon by dots-tb v1.0.1.1 HOTFIX A", path = "lolicon.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_LOLICON"], },
{ name = "ds3vita by xerpi Beta3", path = "ds3vita.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_DS3VITA"], },
{ name = "ds4vita by xerpi v1.2", path = "ds4vita.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_DS4VITA"], },
{ name = "udcd_uvc by xerpi v1.2", path = "udcd_uvc.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_UDCDUVC"], },
{ name = "viimote by xerpi v1.2", path = "viimote.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_VIIMOTE"], },
--{ name = "Kuio by Rinnegatamante", path = "kuio.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_KUIO"], },
{ name = "Adrenaline by TheOfficialFloW (Fix double touch)", path = "adrenaline_kernel.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_ADRENALINE"], },
{ name = "DSMotion by OperationNT414C v1.2", path = "dsmotion.skprx", section = "KERNEL",  path2 = "dsmotion.suprx", section2 = "ALL", config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_DSMOTION"], },
{ name = "usbmc by yifanlu v6 (only for PSTV)", path = "usbmc.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_USBMC"], },
{ name = "AnalogsEnhancer by Rinnegatamante v1.0", path = "AnalogsEnhancer.skprx", section = "KERNEL",  path2 = false, section2 = false, config = "config.txt", configpath = "ux0:data/AnalogsEnhancer/", version = "0001", desc = LANGUAGE["INSTALLP_DESC_ANALOGSENHANCER"], },
{ name = "ioplus by dots-tb v0.1", path = "ioplus.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_IOPLUS"], },
{ name = "Vitacheat Z05 BETA by r0ah", path = "vitacheat.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_VITACHEAT"], },
{ name = "NoPSMWhitelist by SilicaAndPina v1.0 (only for PSTV)", path = "noPsmWhitelist.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_NOPSMWHITE"], },
{ name = "AnalogStickDisable by Hack-Usagi v1.1", path = "AnalogStickDisable.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0002", desc = LANGUAGE["INSTALLP_DESC_ANALOGSTICK"], },
{ name = "cidSpoofer by SilicaAndPina v1.0", path = "cidSpoof.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_CIDSPOOF"], },
{ name = "MakePsmGreatAgain by SilicaAndPina v1.3", path = "MakePsmGreatAgain.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_MAKEPSM"], },
  
--Boot_config.txt
{ name = "Custom Boot Splash by Princess of Sleeping", path = "custom_boot_splash.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_CUSTOMBOOTSPLASH"], },

--Main
{ name = "Download Enabler by TheOfficialFloW v5 (VitaTweaks) v.04", path = "download_enabler.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_DENABLER"], },
{ name = "NoLockScreen v2 by TheOfficialFloW (VitaTweaks)", path = "nolockscreen.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_NOLOCKSCREEN"], },
{ name = "NoTrophyMsg by TheOfficialFloW (VitaTweaks)", path = "notrophymsg.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_NOTROPHYMSG"], },
{ name = "Custom Warning v2 by TheOfficialFloW (VitaTweaks)", path = "custom_warning.suprx", section = "main",  path2 = false, section2 = false, config = "custom_warning.txt", version = "0001", desc = LANGUAGE["INSTALLP_DESC_CUSTOMWARNING"], },

{ name = "Shellbat by nowrep v0.9", path = "shellbat.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_SHELLBAT"], },
{ name = "Shellsecbat by OperationNT414C v0.9", path = "shellsecbat.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_SHELLSECBAT"], },
{ name = "pngshot by xyzz v1.2", path = "pngshot.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_PNGSHOT"], },
{ name = "Vflux by Applelo v0.5", path = "vflux.suprx", section = "main",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_VFLUX"], },
{ name = "Autoboot by Rinnegatamante v1.2 (only for 3.60/3.65)", path = "AutoBoot.suprx", section = "main",  path2 = false, section2 = false, config = false, configpath = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_AUTOBOOT"], },

--All
{ name = "PSV-VSH MENU by joel16 v3.4", path = "vsh.suprx", section = "ALL",  path2 = "kuio.skprx", section2 = "KERNEL", config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_VSHMENU"], },-- Need kuio.skprx
{ name = "VitaGrafix by Electry v4.1", path = "vitagrafix.suprx", section = "ALL",  path2 = "ioplus.skprx", section2 = "KERNEL", config = "config.txt", configpath = "ux0:data/VitaGrafix/", version = "0002", desc = LANGUAGE["INSTALLP_DESC_VITAGRAFIX"], },-- Need kuio.skprx
{ name = "Oclock Vita by frangarcj v1.2.1", path = "oclockvita.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_OVERCLOCK"], },
{ name = "Framecounter by Rinnegatamante v1.2", path = "Framecounter.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_FRAMECOUNTER"], },
{ name = "VGi by Electry v0.4", path = "VGi.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_VGI"], },
{ name = "FuckPSSE by SilicaAndPina v1.1", path = "FuckPSSE.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_FUCKPSSE"], },
{ name = "PSMPatch by SilicaAndPina v1.1", path = "PSMPatch.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_PSMPATCH"], },
{ name = "ITLS-Enso by SKGleba v2.0", path = "itls.suprx", section = "ALL",  path2 = "ioplus.skprx", section2 = "KERNEL", config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_ITLSENSO"], },
{ name = "TropHAX by SilicaAndPina v2.0", path = "trophax2.0.suprx", section = "ALL",  path2 = false, section2 = false, config = false, version = "0001", desc = LANGUAGE["INSTALLP_DESC_TROPHAX"], },


}
