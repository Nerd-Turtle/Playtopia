extends SceneTree
## Exercises real physics and the desktop input adapter, without extra plugins.
var failures: int = 0

func _initialize() -> void:
	call_deferred("_run")

func check(condition: bool, message: String) -> void:
	if not condition:
		failures += 1
		push_error(message)

func frames(count: int) -> void:
	for index in range(count):
		await physics_frame

func _run() -> void:
	var packed = load("res://scenes/world/neighborhood.tscn")
	if packed == null:
		push_error("Main scene failed to load")
		quit(1)
		return
	var world = packed.instantiate()
	root.add_child(world)
	var player = world.get_node("DesktopPlayer")
	var door = world.get_node("Door")
	await frames(30)
	check(player.is_on_floor(), "Player should land on the grass")
	var start: Vector3 = player.global_position
	Input.action_press("move_right")
	await frames(30)
	Input.action_release("move_right")
	check(player.global_position.x > start.x + 1.0, "D should move the player")
	Input.action_press("jump")
	await frames(10)
	Input.action_release("jump")
	check(player.global_position.y > start.y + 0.3, "Space should jump")
	await frames(90)
	check(player.is_on_floor(), "Player should land after jumping")
	# The closed door must physically block entry.
	player.global_position = Vector3(0, 0.1, -3.3)
	player.velocity = Vector3.ZERO
	Input.action_press("move_forward")
	await frames(40)
	Input.action_release("move_forward")
	check(player.global_position.z > -4.5, "Closed door should block entry")
	check(player.interaction_target() == door, "Nearby door should be selectable")
	Input.action_press("interact")
	await frames(3)
	Input.action_release("interact")
	await create_timer(0.5).timeout
	check(door.is_open, "E should open the nearby door")
	check(door.get_node("Hinge/Panel/CollisionShape3D").disabled, "Open door must allow entry")
	Input.action_press("move_forward")
	await frames(35)
	Input.action_release("move_forward")
	check(player.global_position.z < -5.3, "Player should walk through the open doorway")
	Input.action_press("interact")
	await frames(3)
	Input.action_release("interact")
	await create_timer(0.5).timeout
	check(not door.is_open, "E should close the nearby door")
	check(not door.get_node("Hinge/Panel/CollisionShape3D").disabled, "Closed door collision should return")
	player.global_position = Vector3(10, 0.2, 8)
	door.interact(player.global_position)
	check(not door.is_open, "A distant actor must not operate the door")
	Input.action_press("reset_player")
	await frames(3)
	Input.action_release("reset_player")
	check(player.global_position.distance_to(player.spawn_position) < 0.3, "R should return home")
	player.global_position.y = -10.0
	await frames(3)
	check(player.global_position.distance_to(player.spawn_position) < 0.3, "Falling should return home")
	world.queue_free()
	await process_frame
	print("Playtopia smoke test: %d failure(s)" % failures)
	quit(0 if failures == 0 else 1)
