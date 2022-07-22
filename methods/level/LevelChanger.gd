extends Node
class_name Level_Changer

func change_level(i):
		var level = ("res://scenes/level/Level_" + str(int(get_tree().current_scene.name) + i) + ".tscn")
		print(level)
		var level_file = File.new()
		if level_file.file_exists(level):
			get_tree().change_scene(level)
			return
			
		change_level(i + 1)
