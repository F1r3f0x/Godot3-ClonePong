# Ball Script
# F1r3f0x - 2018
extends KinematicBody2D

const random_dir_y_min = -0.4
const random_dir_y_max = 0.4

export (bool) var PLAYING
export (bool) var RANDOM_START_DIRECTION
export var START_DIRECTION = Vector2()

export (float) var INITIAL_SPEED
onready var SPEED = INITIAL_SPEED

var direction = Vector2()


func _ready():
	set_physics_process(false)
	if PLAYING:
		call_deferred("play") # To make sure that is executed after the root node


# Initializes the ball
func play():
	PLAYING = true
	set_physics_process(true)
	if RANDOM_START_DIRECTION:
		direction = get_random_direction()
	else:
		direction = START_DIRECTION
		
func stop():
	PLAYING = false
	set_physics_process(false)
	

func boop():
	$Audio.play()


func _physics_process(delta):
	# Move ball every frame
	move_and_collide(direction.normalized() * SPEED * delta)
	
	# Clamp to walls
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)
	
	# Walls collision
	#if (direction.x >= 0 and position.x >= 1024) or (direction.x < 0 and position.x <=0):
	#	direction.x *= -1
	#	boop()
		
	if (direction.y >= 0 and position.y >= 600) or (direction.y < 0 and position.y <=0):
		direction.y *= -1
		boop()
		
	# Change particles direction
	$Particles.process_material.gravity = Vector3(direction.x, direction.y, 0).normalized() * -50
	
	if SPEED >= 100:
		$Particles.emitting = true
	else:
		$Particles.emitting = false


func get_random_direction():
	var x_dir = [-1, 1]
	return Vector2(x_dir[randi() % 2], rand_range(random_dir_y_min, random_dir_y_max))		