extends Spatial

func _on_LevelChangerBody_body_entered(body: Node) -> void:

	if body.is_in_group("Player"):
		var levels = range(1,9)
		for i in range(1,11):
			var level = ("res://scenes/level/Level_" + str(int(get_tree().current_scene.name) + i) + ".tscn")
			print(level)
			get_tree().change_scene(level)
