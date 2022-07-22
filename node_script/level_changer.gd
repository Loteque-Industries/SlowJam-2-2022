extends Level_Changer

func _on_LevelChangerBody_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		change_level(1)

func _on_PlayButton_pressed() -> void:
	change_level(1)
