extends LevelDefault


func _on_wizard_tower_player_entered_door(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/levels/test_interior.tscn")
