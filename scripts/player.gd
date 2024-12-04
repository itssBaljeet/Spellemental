extends CharacterBody2D

signal spell_input(pos, player_direction)
signal secondSpell_input(pos, player_direction)
signal handpos(pos)
signal hands(texture)

var can_spell: bool = true
var can_secondSpell: bool = true
var markPos: Vector2
var coin_count: int = 0
var heartList : Array[Variant]
@onready var hitPointList : BoxContainer = %Hitpoints
@onready var fullHeart : CompressedTexture2D = preload("res://graphics/player/full_heart.png")
@onready var halfHeart : CompressedTexture2D = preload("res://graphics/player/half_heart.png")
@onready var emptyHeart : CompressedTexture2D = preload("res://graphics/player/empty_heart.png")
@export var healthComponent : HealthComponent

func _ready() -> void:
	updateHPUI()

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

func updateMaxHPUI():
	heartList = []
	for i in range(0, healthComponent.MAX_HEALTH, 2):
		var hpVariant = clamp(healthComponent.health-i, 0, 2)
		heartList.append(hpVariant)

func updateHPUI():
	var freeList = hitPointList.get_children()
	for child in freeList:
		child.queue_free()
	
	updateMaxHPUI()

	for i in range(heartList.size()):
		if heartList[i] == 0:
			var texture = TextureRect.new()
			texture.texture = emptyHeart
			texture.set_expand_mode(TextureRect.EXPAND_KEEP_SIZE)
			texture.set_stretch_mode(TextureRect.STRETCH_KEEP_ASPECT_CENTERED)
			texture.set_h_size_flags(Control.SIZE_EXPAND_FILL)
			hitPointList.add_child(texture)
			
		elif heartList[i] == 1:
			var texture = TextureRect.new()
			texture.texture = halfHeart
			texture.set_expand_mode(TextureRect.EXPAND_KEEP_SIZE)
			texture.set_stretch_mode(TextureRect.STRETCH_KEEP_ASPECT_CENTERED)
			texture.set_h_size_flags(Control.SIZE_EXPAND_FILL)
			hitPointList.add_child(texture)
			
		elif heartList[i] == 2:
			var texture = TextureRect.new()
			texture.texture = fullHeart
			texture.set_expand_mode(TextureRect.EXPAND_KEEP_SIZE)
			texture.set_stretch_mode(TextureRect.STRETCH_KEEP_ASPECT_CENTERED)
			texture.set_h_size_flags(Control.SIZE_EXPAND_FILL)
			hitPointList.add_child(texture)

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
