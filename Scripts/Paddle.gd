# Paddle Script
# F1r3f0x - 2018
extends Area2D


# References
onready var viewport_size = get_viewport_rect().size
onready var particles = preload("res://Scenes/HitParticles.tscn")
var ball_ref

# Input Stuff
enum CONTROLLER {PLAYER_1, PLAYER_2, GAME}
export (int, "Player 1", "Player 2", "Game") var PADDLE_CONTROLLER
var player_inputs = {}


# Vars
export (bool) var PLAYING
export (int) var SPEED
var INITIAL_SPEED = SPEED
var max_y = 0
var min_y = 0
export (float, 0, 1) var CORNER_RANGE  # Height range to bounce from corner
export var RANDOMNESS_RANGE = Vector2() # Randomness to add when hit in the center
var last_direction

var pad_height_from_center


func _ready():
	pad_height_from_center = $Sprite.texture.get_size().y / 2
	
	min_y = $Sprite.texture.get_size().x / 2
	max_y = viewport_size.y - $Sprite.texture.get_size().x / 2
	
	match PADDLE_CONTROLLER:
		0:
			player_inputs = {"up":		"player_1_up",
						     "down":	"player_1_down"}
		1:
			player_inputs = {"up":		"player_2_up",
						     "down":	"player_2_down"}
	set_process(false)
							
func play():
	PLAYING = true
	set_process(true)
func stop():
	PLAYING = false
	set_process(false)

func _process(delta):
	# Input
	if PADDLE_CONTROLLER != CONTROLLER.GAME:
		if Input.is_action_pressed(player_inputs["up"]):
			move(-1, delta)
		if Input.is_action_pressed(player_inputs["down"]):
			move(1, delta)
	else:
		# AI
		if ball_ref:
			if ball_ref.position.y > position.y + pad_height_from_center:
				move(1, delta)
			elif ball_ref.position.y < position.y - pad_height_from_center:
				move(-1, delta)
	
	# Clamp Paddle
	position.y = clamp(position.y, min_y, max_y)			


func move(dir, delta):
	position.y += dir * SPEED * delta


func _on_Paddle_body_entered(body):
	var ball = body
	
	ball.boop()
	
	var inverted_ball_initial_dir = ball.direction * -1
	ball.direction.x *= -1
	
	
	# Corner handling
	var diff_vector = ball.position - position
	var normal_diff_vector = diff_vector.normalized()
	var abs_diff_y = abs(normal_diff_vector.y)
	if abs_diff_y >= CORNER_RANGE:
		if normal_diff_vector.y >= 0:
			ball.direction.y = 1
		else:
			ball.direction.y = -1
	else:
		# Add Randomness if hits in the center
		var randomness = rand_range(RANDOMNESS_RANGE.x, RANDOMNESS_RANGE.y)
		ball.direction.y = randomness

	## Spawn Particles
	var hit_particles = particles.instance()
	$ParticlesStart.position = Vector2(diff_vector.x, diff_vector.y)
	
	# Calculate rotation degrees
	var radians_diff = atan2(inverted_ball_initial_dir.y, inverted_ball_initial_dir.x)
	var degrees = radians_diff * 180/PI
	hit_particles.rotation_degrees = degrees
	
	hit_particles.position = $ParticlesStart.position
	hit_particles.emitting = true
	add_child(hit_particles)
	##