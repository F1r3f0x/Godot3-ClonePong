extends Area2D

# References
onready var viewport_size = get_viewport_rect().size
onready var sprite = $Sprite


# Input Stuff
enum CONTROLLER {PLAYER_1, PLAYER_2, GAME}
export (int, "Player 1", "Player 2", "Game") var PADDLE_CONTROLLER
var player_inputs = {}


# Vars
export (int) var SPEED
var INITIAL_SPEED = SPEED
var max_y = 0
var min_y = 0


func _ready():
	min_y = sprite.texture.get_size().x / 2
	max_y = viewport_size.y - sprite.texture.get_size().x / 2
	
	match PADDLE_CONTROLLER:
		0:
			player_inputs = {"up":		"player_1_up",
						     "down":	"player_1_down"}
		1:
			player_inputs = {"up":		"player_2_up",
						     "down":	"player_2_down"}

func _process(delta):
	# Input
	if PADDLE_CONTROLLER != CONTROLLER.GAME:
		if Input.is_action_pressed(player_inputs["up"]):
			move(-1, delta)
		if Input.is_action_pressed(player_inputs["down"]):
			move(1, delta)

	# Clamp Paddle
	position.y = clamp(position.y, min_y, max_y)			


func move(dir, delta):
	position.y += dir * SPEED * delta



func _on_Paddle_body_entered(body):
	var ball = body
	ball.direction.x *= -1
