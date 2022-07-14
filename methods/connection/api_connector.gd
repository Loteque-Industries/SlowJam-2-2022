extends HTTPRequest
class_name API_Connector
	
var CONFIG_FILE: String = "res://.app_config/.config.json"
	
func _ready() -> void:
	pass
	
func api_connect(api_url: String, endpoint: String, api_key: String = "false"):
	return request(api_url + endpoint)
	#return result
	
func get_api_url(file_path: String, api_name: String, file_type: String = "tres"):
	var url: String
	if file_type == "tres":
		url = load(file_path).api_url
	
	elif file_type == "json":
		url = load_json_file(file_path)[api_name]["url"]
	
	return url
	
func get_api_key(file_path: String, api_name: String, file_type: String = "tres"):
	var key: String
	if file_type == "tres":
		key = load(file_path).api_key
	
	elif file_type == "json":
		key = load_json_file(file_path)[api_name]["key"]
	
	return key
	
func load_json_file(file_path: String):
	var text
	var result
	var result_json
	var dict = {}
	var file = File.new()
	file.open(file_path, file.READ)
	text = file.get_as_text()
	result_json = JSON.parse(text)
	result = result_json.result
	return result 
