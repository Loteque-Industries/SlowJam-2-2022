extends Spatial

onready var psychic_text: String
onready var response_text: String

func _ready() -> void:
	pass


func _on_LineEdit_text_entered(new_text: String) -> void:
	psychic_text = new_text
	$Viewport/UIActor/TextBox/ActorTextOutput.set_text(psychic_text)
	# do an area check to see if other Actor are around
	# If there are npc around
		# find and pick nearest npc
		# display $psychic_text in $ActorTextOutput
		# send $psychic_text to nearest npc
		# nearest actor does stuff with $psychic_text
	# Else
		# wait for httprequest to complete
		
func _on_HTTPRequestDemo_request_completed(
	result: int, 
	response_code: int, 
	headers: PoolStringArray, 
	body: PoolByteArray) -> void:
	response_text = body.get_string_from_utf8()
	$Viewport/UIActor/TextBox/ActorTextOutput.set_text(response_text)
	# display $response_text in $ActorTextOutput
