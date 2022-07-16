extends KinematicBody

onready var door_guard_data = load("res://data/actor/guard.tres")

var target

func _process(delta: float) -> void:
	if target:
		look_at(target.global_transform.origin, Vector3.UP)

func _on_Area_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		target = body
		print(body.name + " entered")
		set_color(Color(1, 0, 0))
	
func _on_Area_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		target = null
		print(body.name + " exited")
		set_color(Color(0, 1, 0))

func set_color(color):
	$MeshInstance.get_surface_material(0).set_albedo(color)
