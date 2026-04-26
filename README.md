# SE2-Launch-Fix-Fedora-Nvidia
This script was baked up for my issues trying to get SE2 to the main menu. I have wiped my compatdata and retested my script.

NOTE: I only have my one desktop to test from. Nvidia card, AMD CPU. I feel as if this script could be beneficial to someone, so here it is. It took a lot of troubleshooting, wipes, and reinstalls to get the game to where it is now on my PC.

I'm not responsible for your actions, if your install breaks or something happens, pull logs and read through to see the errors. Everyone's PC is different, I cannot guarantee this works, only that it worked for me.

Remember to change your launch options, and disable the steam overlay. Right click on the game, select Properties, then General, uncheck the steam overlay option, and paste the launch options as prompted. As of writing this, my launch options are: DISABLE_PRESSURE_VESSEL=1 PROTON_HIDE_NVIDIA_GPU=1 VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.x86_64.json SDL_VIDEODRIVER=x11 %command% -nosplash -skipintro
