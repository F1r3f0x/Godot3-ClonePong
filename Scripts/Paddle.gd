extends Area2D

enum CONTROLLER {PLAYER_1, PLAYER_2, GAME}
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

func _process(delta):
	if PADDLE_CONTROLLER != CONTROLLER.GAME:
		if Input.is_action_pressed(player_inputs["up"]):
			print("up")
			# move up()
		if Input.is_action_pressed(player_inputs["down"]):
			print("down")
			# move down()