extends Node
## Only this adapter reads desktop keys. Gameplay receives intentions instead.

func movement() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_forward", "move_back")

func wants_jump() -> bool:
	return Input.is_action_just_pressed("jump")

func wants_interact() -> bool:
	return Input.is_action_just_pressed("interact")

func wants_reset() -> bool:
	return Input.is_action_just_pressed("reset_player")
