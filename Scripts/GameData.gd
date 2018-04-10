# GameData Script
# This script stores multi scene data, in this case it stores the gamemode selected on the main menu
# F1r3f0x - 2018
 
extends Node

enum GAMEMODES {GAMEMODE_VS, GAMEMODE_SOLO}

var gamemode

func _ready():
	if not gamemode:
		gamemode = GAMEMODES.GAMEMODE_SOLO