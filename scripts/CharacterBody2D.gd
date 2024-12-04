extends CharacterBody2D

var direction: Vector2 = Vector2.LEFT
var playerPos: Vector2
var run: bool = false
@export var attack_damage : int = 1
@export var knockback_force : float = 10.0
@onready var timer : Timer = $HitTimer
var canHit : bool = true

func _process(delta):
	
	# Flip sprite based on player location
	var direction = (playerPos - position).normalized().x
	if direction < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction > 0:
		$AnimatedSprite2D.flip_h = false
		
	if run == true:
		$AnimatedSprite2D.animation = "run"
		velocity = 800 * (playerPos - position).normalized() * delta
		move_and_slide()
	
	else:
		$AnimatedSprite2D.animation = "default"
		velocity = 0 * (playerPos - position).normalized() * delta
		
func _on_player_handpos(pos):
	playerPos = pos


func _on_run_walk_timeout():
	if run == false:
		run = true
	else:
		run = false


func _on_hit_box_component_area_entered(area: Area2D) -> void:
	if area is HitBoxComponent and canHit:
		canHit = false
		var hitBox : HitBoxComponent = area 
		if hitBox.isPlayer:
			var attack = Attack.new()
			attack.damage = attack_damage
			attack.knockback_force = knockback_force
		
			hitBox.damage(attack)
			timer.start()
		else:
			canHit = true

func _on_hit_timer_timeout() -> void:
	canHit = true
