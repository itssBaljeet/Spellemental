extends Area2D

signal markPos(pos)
signal rad_exceed(pos)
var playerPos
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_global_mouse_position()
	$".".look_at(mouse_pos)
	var spell_markers = $Hands/SpellMarker.get_children()
	var selected_marker = spell_markers[randi() % spell_markers.size()]
	markPos.emit(selected_marker.global_position)
	if Input.is_action_pressed("special"):
		# Distance between player and mouse
		var mouse_delta = get_global_mouse_position() - playerPos
		# Gets direction by normalizing Vector
		var dir = mouse_delta.normalized()
		print(dir)
		# Multiplies the direction by whatever I want the radius of the circle around the player to be
		var cursorVector = dir * 50
		var finalPos = playerPos + cursorVector
		position = mouse_pos
		# (playerPos - mouse_pos).length >  
		if (playerPos.distance_to(mouse_pos) > cursorVector.length()):
			rad_exceed.emit(finalPos)
			position = finalPos
	else:
		position = playerPos

func _on_player_handpos(pos):
	playerPos = pos


func _on_player_hands(texture):
	$Hands.texture = texture
