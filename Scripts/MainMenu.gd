# Main Menu Script
# F1r3f0x - 2018
extends Node

func _ready():
	GameData.ingame = false
	$GUI/HBoxContainer/AIGame.grab_focus()

func _on_AIGame_pressed():
	GameData.gamemode = GameData.GAMEMODES.GAMEMODE_SOLO
	GameData.ingame = true
	get_tree().change_scene("res://Scenes/Main.tscn")


func _on_VSGame_pressed():
	GameData.gamemode = GameData.GAMEMODES.GAMEMODE_VS
	GameData.ingame = true
	get_tree().change_scene("res://Scenes/Main.tscn")