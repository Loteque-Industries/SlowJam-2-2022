extends Spatial

func _on_LevelChangerBody_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		print("res://scenes/level/Level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")
		get_tree().change_scene("res://scenes/level/Level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")
		#get_tree().change_scene("res://scenes/level/Level_1.tscn")
