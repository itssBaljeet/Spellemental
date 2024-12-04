extends CharacterBody2D

var direction: Vector2 = Vector2.LEFT
var playerPos: Vector2
var canHit : bool = true
@onready var timer : Timer = $HitTimer
@export var attack_damage : int = 1
@export var knockback_force : float = 10.0

func _process(delta):
	velocity = 800 * (playerPos - position).normalized() * delta
	move_and_slide()
	
	var direction = (playerPos - position).normalized().x

	if direction < 0:
		$AnimatedSprite2D.flip_h = false
	elif direction > 0:
		$AnimatedSprite2D.flip_h = true
		
func _on_player_handpos(pos):
	playerPos = pos


func _on_hitbox_component_area_entered(area: Area2D) -> void:
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
