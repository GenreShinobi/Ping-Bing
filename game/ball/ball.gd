extends Node2D


func _ready() -> void:
	setStartingPosition()


func setStartingPosition() -> void:
	position.x = Screen.HALF_SCREEN_WIDTH
	position.y = Screen.HALF_SCREEN_HEIGHT
