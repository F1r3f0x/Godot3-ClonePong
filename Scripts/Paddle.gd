extends Area2D

export (int, "Player 1", "Player 2", "Game") var PADDLE_CONTROLLER

var player_inputs = {}


func _ready():
	match PADDLE_CONTROLLER:
		0:
			player_inputs = {"up":		"player_1_up",
						     "down":	"player_1_down"}
		1:
			player_inputs = {"up":		"player_2_up",
						     "down":	"player_2_down"}

func _on_Paddle_area_entered(area):
	print("PADDLE HIT!")
