extends LevelDefault



func _on_tower_exit_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/levels/test_level.tscn")


func _on_tower_second_floor_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/levels/test_interior_second.tscn")
