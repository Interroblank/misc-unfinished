# misc-unfinished
Various projects of mine that have been put on indefinite hiatus.

Every project here is being uploaded as-is, in the state that each was left in before development halted. I recognize now that poor programming practice is evident in some of this older work. The dungeon generator especially is colossal, totally un-modularized, full of needless repetition, and so on. But I'm leaving everything here in such a state for posterity, as a record of my growth as an engineer.

## SettleSim
This was to be a primarily text-based god game written in Lua for the LÖVE Engine. It was abandoned as I grew bored of the limitations of the style of design that I had decided on for this project and the crudeness of the engine for which I chose to write it.

## LiteDungeon DungeonGenerator
This is a nearly-complete dungeon generation algorithm that I wrote in Lua for Roblox and using the Roblox API, under the moniker of 'TurquoiseLazarus'. This was a project I undertook around the time that I decided to learn the Lua scripting language. It operates by selecting a boss room from a given list of boss rooms, connecting the starting room to the boss room via a straight line of rooms (the number of which will depend on the given size of the dungeon), and sprouting several chains of rooms off from this main path (again, the number of which is dictated by the given dungeon size) and peppering item rooms throughout.
