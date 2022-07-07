extends KinematicBody2D

var speed = Vector2(400.0, 0)
onready var starting_position = Vector2(Screen.HALF_SCREEN_WIDTH, Screen.HALF_SCREEN_HEIGHT)
var starting_speed = speed


func _ready() -> void:
	setStartingPosition()
	setStartingSpeed()


func _physics_process(delta :float):
	if State.current_game_state == State.GAME_STATE.PLAY:
		var collision = move_and_collide(speed * delta)
		
		if collision:
			if collision.collider.is_in_group("paddle"):
				speed = speed * Vector2(-1, 1)
				print(collision.collider.get_groups())
				if collision.collider.is_in_group("paddle_top"):
					speed.y = -400.0
				elif collision.collider.is_in_group("paddle_bot"):
					speed.y = 400.0
				elif collision.collider.is_in_group("paddle_mid"):
					speed.y = 0.0
			if collision.collider.is_in_group("boundary"):
				speed = speed * Vector2(1, -1)
				

func _process(delta :float):
	var fps = Engine.get_frames_per_second()
	var lerp_interval = speed / fps
	var lerp_position = global_transform.origin + lerp_interval
	
	if fps > 60:
		set_as_toplevel(true)
		global_transform.origin = global_transform.origin.linear_interpolate(lerp_position, 20 * delta)
	else:
		global_transform = global_transform
		set_as_toplevel(false)

func setStartingPosition() -> void:
	position = starting_position


func setStartingSpeed() -> void:
	var player_paddle = get_tree().get_nodes_in_group("player_paddle")[0]
	if player_paddle.right_paddle:
		speed = -speed
		starting_speed = speed
