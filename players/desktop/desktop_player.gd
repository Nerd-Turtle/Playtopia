extends CharacterBody3D
## Desktop movement. A future XR rig will be a separate scene using shared doors.

@export var walk_speed: float = 4.5
@export var jump_speed: float = 6.0
@onready var controls = $DesktopInput
@onready var camera: Camera3D = $Camera3D
@onready var avatar: Node3D = $Avatar
var spawn_position: Vector3
var gravity: float = float(ProjectSettings.get_setting("physics/3d/default_gravity"))

func _ready() -> void:
	spawn_position = global_position
	camera.look_at(global_position + Vector3.UP)

func _physics_process(delta: float) -> void:
	var axes: Vector2 = controls.movement()
	# Fixed camera: W goes toward the house. No mouse capture or fast camera spin.
	var direction := Vector3(axes.x, 0.0, axes.y)
	velocity.x = direction.x * walk_speed
	velocity.z = direction.z * walk_speed
	if not is_on_floor():
		velocity.y -= gravity * delta
	elif controls.wants_jump():
		velocity.y = jump_speed
	move_and_slide()
	if direction.length_squared() > 0.01:
		avatar.rotation.y = lerp_angle(avatar.rotation.y, atan2(direction.x, direction.z), 12.0 * delta)
	if controls.wants_interact():
		var target: Node3D = interaction_target()
		if target != null:
			target.interact(global_position)
	if controls.wants_reset() or global_position.y < -8.0:
		reset_to_spawn()

func reset_to_spawn() -> void:
	global_position = spawn_position
	velocity = Vector3.ZERO

func interaction_target() -> Node3D:
	var closest: Node3D = null
	var closest_distance: float = INF
	for candidate in get_tree().get_nodes_in_group("interactables"):
		if candidate.get_prompt(global_position).is_empty():
			continue
		var distance: float = global_position.distance_squared_to(candidate.global_position)
		if distance < closest_distance:
			closest = candidate
			closest_distance = distance
	return closest
