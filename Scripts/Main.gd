extends Node2D

export (bool) var TESTING
export (NodePath) var ballPath

onready var ball = get_node(ballPath)


func _ready():
	randomize()
	ball.PLAYING = true
	ball.start()


func _process(delta):
	if TESTING:
		ball.position = get_viewport().get_mouse_position()
	