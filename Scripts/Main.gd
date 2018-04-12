# Main Script
# F1r3f0x - 2018
extends Node2D

export (PackedScene) var MessagesScene

export (bool) var TESTING

onready var viewport_rect = get_viewport_rect()

export (NodePath) var BALL_PATH
onready var ball = get_node(BALL_PATH)

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

var hits = 0  # Number of hits to paddles


func _ready():
	randomize()
	$PaddleLeft.ball_ref = ball
	
	if TESTING:
		ball.PLAYING = false
	else:
		new_game()


func new_game():
	score_left = 0
	score_right = 0
	
	ball.RANDOM_START_DIRECTION = false
	
	if gamemode == GAMEMODES.GAMEMODE_VS:
		$PaddleRight.PADDLE_CONTROLLER = $PaddleRight.CONTROLLER.PLAYER_2
	else:
		$PaddleRight.PADDLE_CONTROLLER = $PaddleRight.CONTROLLER.GAME
		$PaddleRight.ball_ref = ball
		$PaddleRight.SPEED = 350
	
	setup_round()
		
	$GUI/Message.text = "Get Ready!"
	$GUI/Message.show_off()
	yield($GUI/Message, "finished")
	$GUI/Message.fade()
	yield($GUI/Message, "finished")
	
	$Timer.start()
	yield($Timer, "timeout")
		
	ball.play()
	
	$PaddleLeft.play()
	$PaddleRight.play()
	
	
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
	
	$PaddleLeft.play()
	$PaddleRight.play()
	
	
func setup_round():
	$PaddleLeft.position = Vector2(
		80,
		viewport_rect.size.y / 2)
		
	$PaddleRight.position = Vector2(
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
	$PaddleLeft.stop()
	$PaddleRight.stop()


func end_game():
	pass


func _process(delta):
	# Update Scores
	label_score_right.text = str(score_right)
	label_score_left.text = str(score_left)
	
	# Follow the mouse pointer if testing
	if TESTING:
		ball.position = get_viewport().get_mouse_position()
		
		if Input.is_key_pressed(KEY_X):
			ball.stop()
		if Input.is_key_pressed(KEY_R):
			new_game()
		
	## Check if a player scores
	if ball.position.x <= score_line_left_x:
			$Audio.play()
			score_right += 1
			ball_start_dir = 1
			new_round()
			
	if ball.position.x >= score_line_right_x:
			$Audio.play()
			score_left += 1
			ball_start_dir = -1
			new_round()
	##


# Increase speed during a round
func _on_Paddle_body_entered(body):
	hits += 1
	if hits >= 4 and ball.SPEED <= 1000:
		hits = 0
		ball.SPEED += 50
