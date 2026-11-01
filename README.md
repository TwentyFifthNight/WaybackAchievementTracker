# Wayback Achievement Tracker

UE4SS Lua mod for **Prologue Go Wayback**. It displays selected achievement progress.

## Requirements

- [UE4SS (3.0.1 experimental)](https://github.com/UE4SS-RE/RE-UE4SS) installed for Prologue Go Wayback.
- [ModMenu 1.4.0](https://github.com/mattdavida/ue4ss-ModMenu) installed in UE4SS's `Mods\shared\ModMenu` directory.

## Installation

1. Install and configure UE4SS for Prologue Go Wayback.
2. Download and extract a ModMenu release into the UE4SS `Mods` directory. Confirm that this file exists:

   ```text
   ue4ss\Mods\shared\ModMenu\ModMenu.lua
   ```

3. Copy the `WaybackAchievementTracker` folder from this project into `ue4ss\Mods`. The resulting layout should be:

   ```text
   ue4ss\Mods\
     shared\
       ModMenu\
         ModMenu.lua
     WaybackAchievementTracker\
       enabled.txt
       scripts\
         achievement_config.lua
         main.lua
   ```

4. Make sure `WaybackAchievementTracker` is enabled. The included empty `enabled.txt` enables it in UE4SS setups that use marker files. If your installation uses `mods.txt`, make sure it contains:

   ```text
   WaybackAchievementTracker : 1
   ```

5. Launch the game and press **F7** to open the tracker menu.

6. Some achievements may display information about a missing instance. Generally, the instance is not found when:

   - the achievement has already been obtained
   - the achievement is not obtainable in the current game mode
   - player opened the menu from the main menu (just load a save or create a new one and open the menu again)

