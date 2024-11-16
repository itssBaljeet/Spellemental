extends CharacterBody2D

signal spell_input(pos, player_direction)
signal secondSpell_input(pos, player_direction)
signal handpos(pos)
signal hands(texture)

var can_spell: bool = true
var can_secondSpell: bool = true
var markPos: Vector2
var coin_count: int = 0

func _process(delta):
	# Emits players pos for hands
	handpos.emit(position)
	
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	var player_direction = (get_global_mouse_position() - position).normalized()
	
	if player_direction > Vector2.ZERO:
		$"Mage Walk_Run".flip_h = true
	elif player_direction < Vector2.ZERO:
		$"Mage Walk_Run".flip_h = false
	
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_D):
		if $"Mage Walk_Run".animation != "walk":
			$"Mage Walk_Run".animation = "walk"
	else:
		if $"Mage Walk_Run".animation != "idle":
			$"Mage Walk_Run".animation = "idle"
	
	if Input.is_action_pressed("primary") and can_spell:
		can_spell = false
		$DefaultSpellCooldown.start()
		spell_input.emit(markPos, player_direction)
		
	if Input.is_action_pressed("secondary") and can_secondSpell: #and can_secondSpell:
		hands.emit(load("res://graphics/player/fire_hands.png"))
		can_secondSpell = false
		$SecondSpellCooldown.start()
		secondSpell_input.emit(markPos, player_direction)
	elif !Input.is_action_pressed("secondary"):
		hands.emit(load("res://graphics/player/hands.png"))
	
	velocity = direction * 6000 * delta
		
	move_and_slide()
	


func _on_default_spell_cooldown_timeout():
	can_spell = true


func _on_second_spell_cooldown_timeout():
	can_secondSpell = true


func _on_hands_2_mark_pos(pos):
	markPos = pos


func _on_hands_2_rad_exceed(pos):
	#$Camera2D.position = pos
	#print($Camera2D.position)
	pass
