@echo off

@REM Notepad++/VSCODE needs current working directory to be where Caprica.exe is 
cd "C:\Repositories\Public\Starfield Mods\starfield-npc-scaler\Tools"

@echo "Deploying Main Archive to MO2 Mod DIR"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-npc-scaler\Dist\NPCScaler - Main.ba2" "D:\MO2Staging\Starfield\mods\NPCScaler-Experimental"

@REM @echo "Deploying Texture Archive to MO2 Mod DIR"
@REM copy /y "C:\Repositories\Public\Starfield Mods\starfield-npc-scaler\Dist\NPCScaler - Textures.ba2" "D:\MO2Staging\Starfield\mods\NPCScaler-Experimental"
