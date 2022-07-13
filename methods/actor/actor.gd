extends KinematicBody
class_name Actor

func _ready() -> void:
	pass

func update_head_position(
	event: InputEvent, 
	head: Spatial,
	camera: Camera, 
	look_sensitivity: float, 
	camera_x_rotation: float):
	
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * look_sensitivity))
		
		var x_delta = event.relative.y * look_sensitivity
		if camera_x_rotation + x_delta > -92 and camera_x_rotation + x_delta < 89:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta

#Hack to fix a bug with move_and_slide in godot 3.
#discussion/demo: https://www.reddit.com/r/godot/comments/hc4lur/how_to_move_and_stop_correctly_on_slopes_using
func slope(slides : int, velocity: Vector3):
	for i in slides:
		var touched = get_slide_collision(i)
		if is_on_floor() && touched.normal.y < 1.0 && (velocity.x != 0.0 || velocity.z != 0.0):
			velocity.y = touched.normal.y
