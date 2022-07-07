extends Node2D

# pointers
onready var string_value = $StringValue
onready var ball = $Ball
onready var player_paddle = $PlayerPaddle
onready var ai_paddle = $AIPaddle

# states
var is_player_serve = true

var delta_key_press = 0.0
var RESET_DELTA_KEY = 0.0
var MAX_KEY_TIME = 0.3

func _ready() -> void:
	# brute force debugging
	print(OS.get_window_size())
	pass


func _physics_process(delta: float) -> void:
	delta_key_press += delta
	
	match State.current_game_state:
		State.GAME_STATE.MENU:
			changeString("MENU!")
			if(Input.is_key_pressed(KEY_SPACE) and delta_key_press > MAX_KEY_TIME):
				State.changeState(State.GAME_STATE.SERVE)
				delta_key_press = RESET_DELTA_KEY
				
		State.GAME_STATE.SERVE:
			ball.setStartingPosition()
			if is_player_serve:
				ball.speed = ball.starting_speed
				changeString("Player Serve!")
				
			if !is_player_serve:
				ball.speed = -ball.starting_speed
				changeString("AI Serve!")
				
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
				
			if ball.position.x >= Screen.SCREEN_WIDTH:
				State.changeState(State.GAME_STATE.SERVE)
				delta_key_press = RESET_DELTA_KEY
				is_player_serve = player_paddle.right_paddle
				
			
func _draw() -> void:
	pass


func changeString(new_string_value):
	string_value.text = new_string_value
	string_value.set_position(Vector2(Screen.HALF_SCREEN_WIDTH - (string_value.get_font("font").get_string_size(string_value.text).x / 2), string_value.get_font("font").get_height()))
