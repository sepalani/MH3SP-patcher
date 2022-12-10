# MH3 Server Project patcher

The goal of this repository is to provide different ways to patch the game. The
users will pick the one they prefer. Currently, this repository provides:
 - Riivolution patcher _(for emulator and disc users)_
 - ISO patcher _(for USB loader users)_

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

![image](https://user-images.githubusercontent.com/7890055/141628618-89b7814e-0917-4e60-9e51-b3d9b21f0cb9.png)
![image](https://user-images.githubusercontent.com/7890055/141629012-ca09e592-3930-4416-b71a-7614abd5221c.png)

You might also need to add the following entries to your `hosts` file
to redirect the traffic:
```
# Nintendo WFC
127.0.0.1 gpcm.gs.nintendowifi.net
127.0.0.1 gpsp.gs.nintendowifi.net
127.0.0.1 naswii.nintendowifi.net
127.0.0.1 nas.nintendowifi.net
127.0.0.1 gamestats.gs.nintendowifi.net
127.0.0.1 gamestats2.gs.nintendowifi.net
127.0.0.1 wiinat.available.gs.nintendowifi.net
127.0.0.1 wiinat.natneg1.gs.nintendowifi.net
127.0.0.1 wiinat.natneg2.gs.nintendowifi.net
127.0.0.1 wiinat.natneg3.gs.nintendowifi.net
# Monster Hunter 3 (JAP)
127.0.0.1 monhunter3wii.gamestats.gs.nintendowifi.net
127.0.0.1 monhunter3wii.gamestats2.gs.nintendowifi.net
127.0.0.1 monhunter3wii.available.gs.nintendowifi.net
127.0.0.1 monhunter3wii.natneg1.gs.nintendowifi.net
127.0.0.1 monhunter3wii.natneg2.gs.nintendowifi.net
127.0.0.1 monhunter3wii.natneg3.gs.nintendowifi.net
127.0.0.1 monhunter3wii.master.gs.nintendowifi.net
127.0.0.1 monhunter3wii.ms16.gs.nintendowifi.net
# Monster Hunter 3 (EU/US)
127.0.0.1 mh3uswii.available.gs.nintendowifi.net
127.0.0.1 mh3uswii.natneg1.gs.nintendowifi.net
127.0.0.1 mh3uswii.natneg2.gs.nintendowifi.net
127.0.0.1 mh3uswii.natneg3.gs.nintendowifi.net
127.0.0.1 mh3uswii.master.gs.nintendowifi.net
127.0.0.1 mh3uswii.gamestats.gs.nintendowifi.net
127.0.0.1 mh3uswii.gamestats2.gs.nintendowifi.net
127.0.0.1 mh3uswii.ms1.gs.nintendowifi.net
```

## ISO patcher
The ISO patcher is a set of scripts to patch disc images directly. Just put
the game image in the `iso-patcher` folder and run the `patch-images` script
to generate a patched image under the `mh3sp-images` directory.

## Manual patching
A really rough alternative is to patch your game manually, as explained in the
[MH3SP wiki](https://github.com/sepalani/MH3SP/wiki):
 - Patch the game's `main.dol` certificate.
 - Patch the game to use Wiimmfi or AltWFC.

## Licensing
This project is licensed under the AGPLv3. The `iso-patcher` is licensed under
GPLv2 or any later version since it is based on Wiimm's ISO Tools and Wiimmfi
ISO Patcher.
