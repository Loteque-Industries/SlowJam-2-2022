extends Interactable
	
onready var ui_player_input_text_box: Node = get_node("/root/World/UIPlayerInput/TextBox")
onready var input_text_box_line_edit: Node = get_node("/root/World/UIPlayerInput/TextBox/LineEdit")
onready var ui_actor_screen: Node = get_node("UIActorScreen")

func _ready() -> void:
	pass # Replace with function body.

func interact():
	print("Interacted with %s" % name)
	ui_player_input_text_box.show()
	input_text_box_line_edit.grab_focus()
	ui_actor_screen.show()
