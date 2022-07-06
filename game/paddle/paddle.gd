extends Node2D

# padding
var padding := 16.0

# paddle side
export (bool) var right_paddle :bool = false


func _ready() -> void:
	if is_in_group("ai_paddle"):
		setAIPaddleSide()
	setStartingPosition()


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
