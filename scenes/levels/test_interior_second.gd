extends LevelDefault



func _on_tower_first_floor_exit_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/levels/test_interior.tscn")
