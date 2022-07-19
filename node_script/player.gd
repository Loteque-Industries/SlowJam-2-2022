extends Actor

export var speed = 10
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 30
export var look_sensitivity = 0.3
export var throw_force: float = 200
onready var head = $Head
onready var camera = $Head/Camera
onready var arm_camera = $Head/Camera/ViewportContainer/Viewport/ArmCam
var velocity = Vector3()
var camera_x_rotation = 0
var checkpoint
# OBJECT
var collider = null
var previous_collider = null
var picked_up = null

func _input(event: InputEvent) -> void:
	update_head_position(event, head, camera, look_sensitivity, camera_x_rotation)

func _process(delta: float) -> void:
	arm_camera.global_transform = camera.global_transform

func _physics_process(delta: float) -> void:
	var direction = Vector3()
	var head_basis = head.get_global_transform().basis
	
	if Input.is_action_pressed("forward"):
		direction -= head_basis.z
	elif Input.is_action_pressed("back"):
		direction += head_basis.z
	
	if Input.is_action_pressed("left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("right"):
		direction += head_basis.x
		
	direction = direction.normalized()
	velocity.y -= gravity
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_power
		
	velocity = move_and_slide(velocity, Vector3.UP, true, 4, 1.22173, false)
	#Hack to fix a bug with move_and_slide in godot.
	#discussion/demo: https://www.reddit.com/r/godot/comments/hc4lur/how_to_move_and_stop_correctly_on_slopes_using
	#see funcion "slope()"
	var slides = get_slide_count()
	if(slides):
		slope(slides, velocity)
	
	#check for Enemy colisions
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("Enemy"):
			print("tagged by " + collision.collider.name)
			#teleport player to checkpoint
			if !checkpoint: get_tree().reload_current_scene()
			else: self.transform = checkpoint.global_transform
			
	#check for checkpoints
	call_deferred("get_checkpoint")

		
	# telikenisis ablity
	if $Head/Camera/RayCast.is_colliding() && !picked_up:
		collider = $Head/Camera/RayCast.get_collider()
		if collider != previous_collider && previous_collider:
			if previous_collider.has_method("highlight"):
				previous_collider.highlight(false)
			previous_collider = collider
		else:
			previous_collider = collider
			if collider.has_method("highlight"):
				collider.highlight(true)
	
	if Input.is_action_just_pressed("pick"):
		if !collider or (collider && !collider.has_method("pick_up")):
			var bodies = $PickArea.get_overlapping_bodies()
			if !bodies: return
			var smallest_dist = 100000
			var closest_object = null
			for body in bodies:
				var dist = global_transform.origin.distance_to(body.global_transform.origin)
				if dist < smallest_dist && body.has_method("pick_up"): 
					smallest_dist = dist
					closest_object = body
			if picked_up: return
			elif closest_object:
				closest_object.pick_up($Head/Camera/PickPoint)
				closest_object.highlight(false)
				picked_up = closest_object
		else:
			if picked_up: return
			elif collider.has_method("pick_up"):
				collider.pick_up($Head/Camera/PickPoint)
				collider.highlight(false)
				picked_up = collider
				
	if Input.is_action_just_pressed("throw"):
		if !picked_up: return
		picked_up.let_go(-$Head/Camera/PickPoint.global_transform.basis.z * throw_force)
		picked_up = null


func get_checkpoint():
	var new_checkpoints = $CheckpointArea.get_overlapping_areas()
	if !new_checkpoints: return
	else:
		for new_checkpoint in new_checkpoints:
			if new_checkpoint.is_in_group("Checkpoint"):
				checkpoint = new_checkpoint
				print(checkpoint.name)
				checkpoint.get_child(0).disabled = true
