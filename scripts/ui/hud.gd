extends CanvasLayer
@export var player_path: NodePath
@onready var player = get_node(player_path)
@onready var prompt: Label = $Card/Margin/Lines/Prompt

func _process(_delta: float) -> void:
	var target = player.interaction_target()
	prompt.text = "Explore the yard. Walk up to the blue door."
	if target != null:
		prompt.text = "E  ·  " + target.get_prompt(player.global_position)
