extends KinematicBody

onready var door_guard_data = load("res://data/actor/door_guard.tres")
onready var current_mesh = get_child(2)

func _ready() -> void:

	set_material(door_guard_data)
	
	
func set_material(new_material):
	var material = SpatialMaterial.new()
	material.albedo_color = new_material.material.albedo_color
	current_mesh.set_surface_material(0, material)
