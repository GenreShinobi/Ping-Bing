extends Node

# states
enum GAME_STATE {MENU, SERVE, PLAY}

# current state
var current_game_state = GAME_STATE.MENU

# Setters
func changeState(new_state :int) -> void:
	current_game_state = new_state
