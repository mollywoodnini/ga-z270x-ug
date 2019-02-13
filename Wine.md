# Installing Wine

It's important to know there are two ways to go about this. You can do this the self-contained route with a wrapper for each game using Wineskin Winery, or using a system install. Personally, I prefer a system install. This guide will cover the latter. Terminal is used to complete these tasks.

1. First up is installing command line tools `xcode-select --install`
    * This is a set of developer tools not included by defualt with an install of macOS. These tools are also embedded into xcode, but they don't work in the way we need them to.
2. Now you need Homebrew `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
    * One of the best things out there. The missing package manager for macOS and Linux.
3. Wine needs XQuartz to work. `brew cask install xquartz`
    * You should restart now. So the services will start running for Wine.
4. Install Wine. `brew install wine`
5. Install Wine Tricks. `brew install winetricks`
6. I recommend you also install the interface for Wine Tricks. `brew install zenity`
7. You now have all your dependent resources installed to start. Type in `winecfg`
    * Wine will begin its inital setup. When done, you can close the config window.
8. In order to run games, you need to build wine. `winetricks`
    * A new window will appear. Click OK.
    * Choose Install Windows DLL or component. Click OK.
    * A list of all available installs will show.
9. Go through and select the most important to run games. Such as *d3dx9_XX, dinput, dotnetXX, msxmlX and vcrun20XX.* My goal was to cover as much as possible. 
    * Click OK when you have what you need.
10. The window will vanish, Terminal will show progress. When the window comes back, just click Cancel a few times until the window closes.

You can now start games by typing in `wine /path/to/game.exe`.  The terminal will remain open. This is preffered for myself so I can see what errors may happen that are fatal and prevent the game from starting. If you don't want a terminal window, you need to use the self contained Winery.

As for Steam and Steam games, you need to install it through Wine. `wine /path/to/steam-setup.exe`. When it's installed you can adjust the library location for games. For example, I already have some games installed on a storage drive. When I boot into Windows and open Steam I have it configured to be the game library. `D:\Games\Windows\steamapps`. In macOS it is `/Volumes/Storage/Games/Windows/steamapps`. For the Steam in Wine, I have the path set to `Z:\Volumes\Storage\Games\Windows\steamapps`. It will automatically pick up the games. From there I can launch them and play. Some games may simply refuse to run. This is where the community comes in handy. Chances are someone has played this game with Wine on Linux. Give it a search and see if you can find some settings.
