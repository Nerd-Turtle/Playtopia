extends Node3D
## Shared interaction: no keyboard, mouse, touch, or XR API here.
signal toggled(is_open: bool)
@export var interaction_distance: float = 3.0
@onready var hinge: Node3D = $Hinge
@onready var collision: CollisionShape3D = $Hinge/Panel/CollisionShape3D
var is_open: bool = false
var animating: bool = false

func get_prompt(actor_position: Vector3) -> String:
	if actor_position.distance_to(global_position) > interaction_distance or animating:
		return ""
	return "Close door" if is_open else "Open door"

func interact(actor_position: Vector3) -> void:
	if get_prompt(actor_position).is_empty():
		return
	is_open = not is_open
	animating = true
	# Disable while swinging, then restore only for the closed door.
	collision.set_deferred("disabled", true)
	var tween := create_tween()
	tween.tween_property(hinge, "rotation:y", deg_to_rad(-105.0) if is_open else 0.0, 0.35)
	tween.finished.connect(_finish_swing)
	toggled.emit(is_open)

func _finish_swing() -> void:
	collision.set_deferred("disabled", is_open)
	animating = false
