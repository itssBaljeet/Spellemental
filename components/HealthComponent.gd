class_name HealthComponent
extends Node2D
@export var player : CharacterBody2D
@export var MAX_HEALTH := 10.0
var health : float

func _ready() -> void:
	health = MAX_HEALTH
	
func damage(attack : Attack):
	health -= attack.damage
	
	if health <= 0:
		get_parent().queue_free()
	if player:
		player.updateHPUI()

func heal(healthToHeal: int):
	health += healthToHeal
	
	if health > MAX_HEALTH:
		health = MAX_HEALTH
	if player:
		player.updateHPUI()
