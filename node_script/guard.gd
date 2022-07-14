extends KinematicBody

onready var door_guard_data = load("res://data/actor/guard.tres")
onready var current_mesh = get_child(2)

func _ready() -> void:

	set_material(door_guard_data)
	
# should set children of Npc Node as editable in the editor instead.
func set_material(data):
	var material = SpatialMaterial.new()
	material.albedo_color = data.material.albedo_color
	current_mesh.set_surface_material(0, material)
