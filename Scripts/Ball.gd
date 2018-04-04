# Ball Script
# F1r3f0x - 2018
extends KinematicBody2D

onready var particles = $Particles

const random_dir_y_min = -0.4
const random_dir_y_max = 0.4

export (bool) var PLAYING
export (float) var SPEED
var direction = Vector2()


func _ready():
	call_deferred("start") # To make sure that is executed after the root node
	set_process(false)


# Initializes the ball
func start():
	if PLAYING:
		set_process(true)
		direction = get_random_direction()


func _process(delta):
	# Move ball every frame
	move_and_collide(direction.normalized() * SPEED * delta)
	
	# Clamp to walls
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)
	
	# Walls collision
	if (direction.x >= 0 and position.x >= 1024) or (direction.x < 0 and position.x <=0):
		direction.x *= -1
		
	if (direction.y >= 0 and position.y >= 600) or (direction.y < 0 and position.y <=0):
		direction.y *= -1
		
	# Change particles direction
	particles.process_material.gravity = Vector3(direction.x, direction.y, 0).normalized() * -50
	
	if SPEED >= 100:
		$Particles.emitting = true
	else:
		$Particles.emitting = false


func get_random_direction():
	randomize()
	var x_dir = [-1, 1]
	return Vector2(x_dir[randi() % 2], rand_range(random_dir_y_min, random_dir_y_max))		