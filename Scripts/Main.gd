# Main Script
# F1r3f0x - 2018
extends Node2D

export (PackedScene) var MessagesScene

export (bool) var TESTING

onready var viewport_rect = get_viewport_rect()

export (NodePath) var BALL_PATH
onready var ball = get_node(BALL_PATH)

onready var paddle_left= $PaddleLeft
onready var paddle_right = $PaddleRight

onready var label_score_left = $GUI/GUIElements/Score/ScoreLeft
onready var label_score_right = $GUI/GUIElements/Score/ScoreRight

var GAMESIDE = {"LEFT": -1, "RIGHT": 1}

onready var GAMEMODES = GameData.GAMEMODES
onready var gamemode = GameData.gamemode

var score_line_left_x = 0
var score_line_right_x = 1024

var ball_start_dir = 0
var score_left = 0
var score_right = 0
var level = 0

var hits = 0

func _ready():
	randomize()
	
	#paddle_left.ball_ref = ball
	
	if TESTING:
		ball.PLAYING = false
	else:
		new_game()

func new_game():
	score_left = 0
	score_right = 0
	level = 0
	
	ball.RANDOM_START_DIRECTION = false
	
	if gamemode == GAMEMODES.GAMEMODE_VS:
		paddle_right.PADDLE_CONTROLLER = paddle_right.CONTROLLER.PLAYER_2
	else:
		paddle_right.PADDLE_CONTROLLER = paddle_right.CONTROLLER.GAME
		paddle_right.ball_ref = ball
		paddle_right.SPEED = 350
	
	setup_round()
		
	$GUI/Message.text = "Get Ready!"
	$GUI/Message.show_off()
	yield($GUI/Message, "finished")
	$GUI/Message.fade()
	yield($GUI/Message, "finished")
	
	$Timer.start()
	yield($Timer, "timeout")
		
	ball.play()
	
	paddle_left.play()
	paddle_right.play()
	
	
func new_round():
	setup_round()
		
	ball.START_DIRECTION = Vector2(ball_start_dir,0)
	
	$GUI/Message.text = "Get Ready!"
	$GUI/Message.show_off()
	yield($GUI/Message, "finished")
	$GUI/Message.fade()
	yield($GUI/Message, "finished")
	
	$Timer.start()
	yield($Timer, "timeout")
	
	ball.play()
	
	paddle_left.play()
	paddle_right.play()
	
	
func setup_round():
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
	ball.SPEED = ball.INITIAL_SPEED
	
	ball.stop()
	paddle_left.stop()
	paddle_right.stop()


func end_game():
	pass


func _process(delta):
	# Update Scores
	label_score_right.text = str(score_right)
	label_score_left.text = str(score_left)
	
	if TESTING:
		ball.position = get_viewport().get_mouse_position()
	if ball.position.x <= score_line_left_x:
			score_right += 1
			ball_start_dir = 1
			new_round()
	if ball.position.x >= score_line_right_x:
			score_left += 1
			ball_start_dir = -1
			new_round()
			
	if Input.is_key_pressed(KEY_X):
		ball.stop()
	if Input.is_key_pressed(KEY_R):
		new_game()

func _on_Paddle_body_entered(body):
	hits += 1
	if hits >= 4 and ball.SPEED <= 1000:
		hits = 0
		ball.SPEED += 50
		print(ball.SPEED)
