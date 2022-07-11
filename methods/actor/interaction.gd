extends RayCast

var current_collider

onready var interaction_label = get_node("")

func _process(delta: float) -> void:
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			current_collider = collider
			
		if Input.is_action_just_pressed("interact"):
			collider.interact()
	elif current_collider:
		current_collider = null
	else:
		pass
	
func  set_interaction_text(text):
	if !text:
		interaction_label.set_text("")
		interaction_label.set_visible(false)
	else:
		interaction_label.set_text("press %s to %s" % [interact_key, text])
