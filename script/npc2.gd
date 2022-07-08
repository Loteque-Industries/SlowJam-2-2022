extends KinematicBody

onready var ramp_guard_data = load("res://data/actor/ramp_guard.tres")
onready var current_mesh = get_child(2)

func _ready() -> void:

	set_material(ramp_guard_data)
	
	
func set_material(material):
	var new_material = SpatialMaterial.new()
	new_material.albedo_color = material.material.albedo_color
	current_mesh.set_surface_material(0, new_material)
