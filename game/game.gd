extends Node2D

# pointers
onready var string_value = $StringValue
onready var ball = $Ball
onready var player_paddle = $PlayerPaddle
onready var ai_paddle = $AIPaddle
onready var player_score_label = $PlayerScoreLabel
onready var ai_score_label = $AIScoreLabel

const MAX_SCORE = 3
var is_player_win

# states
var is_player_serve = true

var delta_key_press = 0.0
var RESET_DELTA_KEY = 0.0
var MAX_KEY_TIME = 0.3

# scoring
var player_score = 0
var player_score_text = player_score as String
var player_text_half_width
var player_score_position

var ai_score = 0
var ai_score_text = ai_score as String
var ai_text_half_width
var ai_score_position

func _ready() -> void:
	# brute force debugging
	print(OS.get_window_size())
	

func _physics_process(delta: float) -> void:
	delta_key_press += delta
	
	match State.current_game_state:
		State.GAME_STATE.MENU:
			if is_player_win == true:
				changeString("Player wins! Press spacebar to start a new game")
			elif is_player_win != true:
				changeString("Player wins! Press spacebar to start a new game")
			else:
				changeString("Start by pressing the spacebar!")
				
			if(Input.is_key_pressed(KEY_SPACE) and delta_key_press > MAX_KEY_TIME):
				State.changeState(State.GAME_STATE.SERVE)
				delta_key_press = RESET_DELTA_KEY
				
		State.GAME_STATE.SERVE:
			ball.setStartingPosition()
			player_paddle.resetStartingPosition()
			ai_paddle.resetStartingPosition()
			
			if MAX_SCORE == player_score:
				State.changeState(State.GAME_STATE.MENU)
				player_score = 0
				ai_score = 0
				is_player_win = true
			elif MAX_SCORE == ai_score:
				State.changeState(State.GAME_STATE.MENU)
				player_score = 0
				ai_score = 0
				is_player_win = false
			
			if is_player_serve:
				ball.speed = ball.starting_speed
				changeString("Player Serve: press spacebar to serve!")
				
			if !is_player_serve:
				ball.speed = -ball.starting_speed
				changeString("AI Serve: press spacebar to serve!")
				
			if(Input.is_key_pressed(KEY_SPACE) and delta_key_press > MAX_KEY_TIME):
				State.changeState(State.GAME_STATE.PLAY)
				delta_key_press = RESET_DELTA_KEY
				
		State.GAME_STATE.PLAY:
			changeString("PLAY!")
			if(Input.is_key_pressed(KEY_SPACE) and delta_key_press > MAX_KEY_TIME):
				State.changeState(State.GAME_STATE.SERVE)
				delta_key_press = RESET_DELTA_KEY
			
			if ball.position.x <= 0:
				State.changeState(State.GAME_STATE.SERVE)
				delta_key_press = RESET_DELTA_KEY
				is_player_serve = !player_paddle.right_paddle
				if player_paddle.right_paddle:
					player_score += 1
				else:
					ai_score += 1
				
			if ball.position.x >= Screen.SCREEN_WIDTH:
				State.changeState(State.GAME_STATE.SERVE)
				delta_key_press = RESET_DELTA_KEY
				is_player_serve = player_paddle.right_paddle
				if !player_paddle.right_paddle:
					player_score += 1
				else:
					ai_score += 1
	
			player_score_text = player_score as String
			ai_score_text = ai_score as String
	
	player_score_label.text = player_score_text
	ai_score_label.text = ai_score_text
	
	player_score_label.set_position(Vector2((Screen.HALF_SCREEN_WIDTH / 2) - (player_score_label.get_font("font").get_string_size(player_score_label.text).x / 2), string_value.get_font("font").get_height() * 1.5))
	ai_score_label.set_position(Vector2(Screen.HALF_SCREEN_WIDTH + (Screen.HALF_SCREEN_WIDTH / 2) - (ai_score_label.get_font("font").get_string_size(ai_score_label.text).x / 2), string_value.get_font("font").get_height() * 1.5))
	string_value.set_position(Vector2(Screen.HALF_SCREEN_WIDTH - (string_value.get_font("font").get_string_size(string_value.text).x / 2), string_value.get_font("font").get_height() * 0.5))			
			
func _draw() -> void:
	pass


func changeString(new_string_value):
	string_value.text = new_string_value
	string_value.set_position(Vector2(Screen.HALF_SCREEN_WIDTH - (string_value.get_font("font").get_string_size(string_value.text).x), string_value.get_font("font").get_height()))
