# MH3 Server Project patcher

The goal of this repository is to provide different ways to patch the game. The
users will pick the one they prefer. Currently, this repository provides:
 - Riivolution patcher

**This repository only provides patching mechanisms, not the servers you have
to run to play online. So you still have to run the servers on your machine and
setup the proper redirection.**

## Riivolution patcher
### Requirements
 - A real Wii capable of reading discs
 - A SD card with the Riivolution patches

_There are no special requirements on Dolphin emulator._

### How-to (for Wii/WiiU console)
 - Install [Riivolution](https://wiibrew.org/wiki/Riivolution) on the app folder
of your SD card.
 - [Download this repository](https://github.com/sepalani/MH3SP-patcher/archive/refs/heads/master.zip)
and copy the riivolution folder at the root of your SD card.
 - On your Wii, launch the Riivolution app from the Homebrew Channel.
 - Insert your game disc and wait for the options to appear.
 - If you're playing the **Japanese version**, enable `Patch EC check`.
 - Select `Launch` and your game should be patched on the fly.

### How-to (for Dolphin emulator)
 - [Download this repository](https://github.com/sepalani/MH3SP-patcher/archive/refs/heads/master.zip)
and extract it.
 - Right-click on Monster Hunter Tri in your game list and select
`Start with Riivolution Patches`.
 - If the Riivolution patch wasn't extracted to Dolphin's Riivolution folder:
   * Select `Open Riivolution XML...` and browse to the `MH3SP.xml` file.
 - When the patch is loaded, click on the `Start` button to launch the game.

## Manual patching
A really rough alternative is to patch your game manually, as explained in the
[MH3SP wiki](https://github.com/sepalani/MH3SP/wiki):
 - Patch the game's `main.dol` certificate.
 - Patch the game to use Wiimmfi or AltWFC.
