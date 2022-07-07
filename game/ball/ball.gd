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
				speed = -speed

func setStartingPosition() -> void:
	position = starting_position


func setStartingSpeed() -> void:
	var player_paddle = get_tree().get_nodes_in_group("player_paddle")[0]
	if player_paddle.right_paddle:
		speed = -speed
		starting_speed = speed
