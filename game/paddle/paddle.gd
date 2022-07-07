extends Node2D

# padding
var padding := 16.0

# speed
var paddle_speed = Vector2(0.0, 400.0)

onready var panel = $PanelContainer

# paddle side
export (bool) var right_paddle :bool = false


func _ready() -> void:
	if is_in_group("ai_paddle"):
		setAIPaddleSide()
	setStartingPosition()


func _physics_process(delta :float):
	if is_in_group("player_paddle"):
		if(Input.is_key_pressed(KEY_W)):
			position += -paddle_speed * delta
		if(Input.is_key_pressed(KEY_S)):
			position += paddle_speed * delta


func setStartingPosition() -> void:
	if right_paddle:
		position.x = Screen.SCREEN_WIDTH - padding
		position.y = Screen.HALF_SCREEN_HEIGHT
	else:
		position.x = padding
		position.y = Screen.HALF_SCREEN_HEIGHT


func setAIPaddleSide() -> void:
	var player_paddle = get_tree().get_nodes_in_group("player_paddle")[0]
	right_paddle = !player_paddle.right_paddle
