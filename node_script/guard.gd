extends KinematicBody

onready var door_guard_data = load("res://data/actor/guard.tres")

export var speed = 10
var space_state
var target

func _ready() -> void:
	space_state = get_world().direct_space_state
	
func _process(delta: float) -> void:
	if target:
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
		if result.collider.is_in_group("Player"):
			look_at(target.global_transform.origin, Vector3.UP)
			move_to_target(delta)
			set_color(Color(1,0,0))
		else:
			set_color(Color(0,1,0))

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

func move_to_target(delta):
	var direction = (target.get_transform().origin - transform.origin).normalized()
	move_and_slide(direction * speed * delta, Vector3.UP)

func set_color(color):
	$MeshInstance.get_surface_material(0).set_albedo(color)
