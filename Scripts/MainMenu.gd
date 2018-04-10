# Main Menu Script
# F1r3f0x - 2018
extends Node

func _ready():
	$GUI/HBoxContainer/AIGame.grab_focus()

func _on_AIGame_pressed():
	GameData.gamemode = GameData.GAMEMODES.GAMEMODE_SOLO
	get_tree().change_scene("res://Scenes/Main.tscn")


func _on_VSGame_pressed():
	GameData.gamemode = GameData.GAMEMODES.GAMEMODE_VS
	get_tree().change_scene("res://Scenes/Main.tscn")
