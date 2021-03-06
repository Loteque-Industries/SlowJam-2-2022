extends KinematicBody
class_name Enemy

export var wait_time: int
export var speed = 200
export(Array, NodePath) var home

var space_state
var target
var projectile

var timer = Timer.new()

func _ready() -> void:
	space_state = get_world().direct_space_state
	pick_new_home()
	
func _process(delta: float) -> void:
	if target:
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
		
		call_deferred("handle_collision", result, projectile, delta)

	else:
		randomize_home()
		
		
func _on_Area_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		target = body
		print(body.name + " entered")
	elif body.is_in_group("Home") and body.is_in_group("Player") == false:
		pick_new_home()
		print(body.name + " entered")
	elif body.is_in_group("Projectile"):
		projectile = body
		clear_projectile_timer()
		pick_new_home()
		body.remove_from_group("Projectile")
		print(body.name + " entered")
		
func _on_Area_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		randomize_home()
		print(body.name + " exited")
	elif body.is_in_group("Projectile"):
		projectile = null
		print(body.name + " exited")
		
func knock_back(delta):
	var direction = (projectile.get_transform().origin + transform.origin)
	move_and_slide(direction * speed * delta, Vector3.UP)
	
func move_to_target(delta):
	var direction = (target.get_transform().origin - transform.origin).normalized()
	move_and_slide((direction * speed * delta), Vector3.UP).normalized()

func set_color(color):
	$MeshInstance.get_surface_material(0).set_albedo(color)

func pick_new_home():
	timer.connect("timeout", self, "randomize_home")
	timer.wait_time = wait_time
	timer.one_shot = false
	add_child(timer)
	timer.start()

func randomize_home():
	if !home: return
	else: target = get_node(home[randi() % home.size()])

func clear_projectile_timer():
	timer.connect("timeout", self, "clear_projectile")
	timer.wait_time = wait_time
	timer.one_shot = false
	add_child(timer)
	timer.start()
	
func clear_projectile():
	projectile = null
	
func handle_collision(result, projectile, delta):
		if !result:
			return
		else:
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
