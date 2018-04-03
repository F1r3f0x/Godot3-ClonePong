extends Node2D

export (bool) var TESTING
export (NodePath) var ball


func _ready():
	randomize()
	ball = get_node(ball)
	ball.PLAYING = true
	ball.start()


func _process(delta):
	if TESTING:
		ball.position = get_viewport().get_mouse_position()
	