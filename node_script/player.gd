extends Actor

export var speed = 10
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 30
export var look_sensitivity = 0.3

onready var head = $Head
onready var camera = $Head/Camera

var velocity = Vector3()
var camera_x_rotation = 0

func _input(event: InputEvent) -> void:
	update_head_position(event, head, camera, look_sensitivity, camera_x_rotation)
	
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
		
	velocity = move_and_slide(velocity, Vector3.UP, true, 4, 1.22173)
	#Hack to fix a bug with move_and_slide in godot.
	#discussion/demo: https://www.reddit.com/r/godot/comments/hc4lur/how_to_move_and_stop_correctly_on_slopes_using
	#see funcion "slope()"
	var slides = get_slide_count()
	if(slides):
		slope(slides, velocity)
