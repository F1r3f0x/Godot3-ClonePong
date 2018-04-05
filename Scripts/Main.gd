# Main Script
# F1r3f0x - 2018
extends Node2D

export (bool) var TESTING

onready var viewport_rect = get_viewport_rect()

export (NodePath) var BALL_PATH
onready var ball = get_node(BALL_PATH)

onready var paddle_left= $PaddleLeft
onready var paddle_right = $PaddleRight

onready var label_score_left = $GUI/GUIElements/Score/ScoreLeft
onready var label_score_right = $GUI/GUIElements/Score/ScoreRight

enum GAMEMODES {GAMEMODE_VS, GAMEMODE_SOLO}
var GAMESIDE = {"LEFT": -1, "RIGHT": 1}

var gamemode

var score_line_left_x = 0
var score_line_right_x = 1024

var ball_start_dir = 0
var score_left = 0
var score_right = 0
var level = 0


func _ready():
	gamemode = GAMEMODES.GAMEMODE_VS
	randomize()
	
	if TESTING:
		ball.PLAYING = false
	else:
		new_game()
	

func new_game():
	score_left = 0
	score_right = 0
	level = 0
	
	ball_start_dir = GAMESIDE.values()[randi() % GAMESIDE.size()]
	ball.stop()
	
	setup_board()
	
	$Timer.start()
	yield($Timer, "timeout")
	
	if gamemode == GAMEMODES.GAMEMODE_SOLO:
		ball.RANDOM_START_DIRECTION = false
	else:
		ball.RANDOM_START_DIRECTION = true
	ball.start()
	
	
func next_round():
	pass
	
	
func setup_board():
	paddle_left.position = Vector2(
		80,
		viewport_rect.size.y / 2)
		
	paddle_right.position = Vector2(
		944,
		viewport_rect.size.y / 2)
		
	ball.position = Vector2(
		viewport_rect.size.x / 2,
		viewport_rect.size.y / 2)
	ball.direction = Vector2(
		ball_start_dir,
		0)


func end_game():
	pass


func _process(delta):
	if TESTING:
		ball.position = get_viewport().get_mouse_position()
	if ball.position.x <= score_line_left_x:
			new_game()
	if ball.position.x >= score_line_right_x:
			new_game()
			
	if Input.is_key_pressed(KEY_X):
		new_game()