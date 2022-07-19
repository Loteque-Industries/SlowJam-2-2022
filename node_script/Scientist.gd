extends Enemy

onready var door_guard_data = load("res://data/actor/guard.tres")

func _process(delta: float) -> void:
	if target:
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)

		if result.collider.is_in_group("Player"):
			look_at(target.global_transform.origin, Vector3.UP)
			move_to_target(delta)
		else:
			if projectile:
				look_at(projectile.global_transform.origin, Vector3.UP)
				result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
				move_to_target(delta)
			else:
				result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
				look_at(target.global_transform.origin, Vector3.UP)
				move_to_target(delta)
	else:
		randomize_home()
