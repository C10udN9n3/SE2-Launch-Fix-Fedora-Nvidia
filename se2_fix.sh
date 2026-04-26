#!/bin/bash

# 1. Automatic User Detection (No manual entry needed)
CURRENT_USER=$USER
COMPAT_DATA="/home/$CURRENT_USER/.local/share/Steam/steamapps/compatdata/1133870"
GAME_DIR="/home/$CURRENT_USER/.local/share/Steam/steamapps/common/SpaceEngineers2"

# 2. Dependency Check: Ensure Zenity is available for the popups
if ! command -v zenity &> /dev/null; then
    echo "Zenity not found. Installing..."
    sudo dnf install zenity -y
fi

# 3. Confirmation Dialog
zenity --question --title="SE2 Environment Fixer" --text="This will reset the Space Engineers 2 hardware cache and repair the .NET 9 environment for user: $CURRENT_USER.\n\nContinue?" || exit 1

# 4. Nuclear Reset of the broken hardware/UI cache
# This fixes the 'Minimum Requirements' loop
if [ -d "$COMPAT_DATA" ]; then
    echo "Clearing hardware cache..."
    rm -rf "$COMPAT_DATA/pfx/drive_c/users/steamuser/AppData/Roaming/SpaceEngineers2"
fi

# 5. Force Windows 10 Mode
# Essential for .NET 9 to handshake with Proton
echo "Forcing Windows 10 Registry..."
protontricks 1133870 win10

# 6. Run the .NET 9 Desktop Runtime Repair
# This targets the actual Redist file you found in the game folder
echo "Repairing .NET 9 Desktop Runtime..."
if [ -f "$GAME_DIR/redist/dotnet-runtime-9.0-latest.exe" ]; then
    protontricks -c "wine $GAME_DIR/redist/dotnet-runtime-9.0-latest.exe" 1133870
else
    zenity --error --text="Could not find .NET 9 installer in the redist folder. Please verify game files in Steam."
    exit 1
fi

# 7. Final Instructions Popup
zenity --info --title="Fix Applied" --width=400 --text="Environment Repaired!\n\nFINAL STEPS:\n1. Disable Steam Overlay (Properties > General).\n2. Use these Launch Options:\n\nDISABLE_PRESSURE_VESSEL=1 PROTON_HIDE_NVIDIA_GPU=1 VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.x86_64.json SDL_VIDEODRIVER=x11 %command% -nosplash -skipintro"

echo "Process Complete. Fly safe, Engineer."
