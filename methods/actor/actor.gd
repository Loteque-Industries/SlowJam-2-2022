extends Node

class_name = Interactable

get_interaction_text():
	
func get_interaction_text():
	return "Interact"
	
func interact():
	print("Interacted with %s " % name)
