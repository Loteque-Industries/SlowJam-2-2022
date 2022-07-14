extends API_Connector

onready var connection_param = "res://data/connection/swapi.tres" 
onready var api_key: String = get_api_key(connection_param, "swapi", "tres")
onready var api_url: String = get_api_url(connection_param, "swapi", "tres")
onready var endpoint: String

func _ready() -> void:
	pass
	
func _on_HTTPRequest_request_completed(
	result: int, 
	response_code: int, 
	headers: PoolStringArray, 
	body: PoolByteArray) -> void:
	var output = body.get_string_from_utf8()
	print(output)


func _on_LineEdit_text_entered(new_text: String) -> void:
	endpoint = "/people/1/"
	api_connect(api_url, endpoint)
