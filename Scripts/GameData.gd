# GameData Script
# This script stores multi scene data, in this case it stores the gamemode selected on the main menu
# F1r3f0x - 2018
 
extends Node

enum GAMEMODES {GAMEMODE_VS, GAMEMODE_SOLO}

var gamemode

func _ready():
	if not gamemode:
		gamemode = GAMEMODES.GAMEMODE_SOLO
		
func _process(delta):
	if Input.is_action_just_released("ui_quit"):
		get_tree().quit()
	
	if Input.is_action_just_released("ui_fullscreen"):
		if OS.is_window_fullscreen():
			OS.set_window_fullscreen(false)
		else:
			OS.set_window_fullscreen(true)