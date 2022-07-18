extends RayCast
class_name Interaction

var current_collider

onready var interaction_label = get_node("UI/InteractionLabel")
onready var interact_key = InputMap.get_action_list("interact")[0].as_text()

func _ready() -> void:
	set_interaction_text("")

func _process(_delta: float) -> void:
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			set_interaction_text(collider.get_interaction_text())
			current_collider = collider
			
		if Input.is_action_just_pressed("interact"):
			collider.interact()
			set_interaction_text(collider.get_interaction_text())
	elif current_collider:
		current_collider = null
		set_interaction_text("")
		
func  set_interaction_text(text):
	if !text:
		interaction_label.set_text("")
		interaction_label.set_visible(false)
	else:
		interaction_label.set_text("press %s to %s" % [interact_key, text])
		interaction_label.set_visible(true)
		
