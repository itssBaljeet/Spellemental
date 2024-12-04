extends Area2D
class_name HitBoxComponent

@export var healthComponent : HealthComponent
@export var damageFlashComponent : DamageFlashComponent
@export var isPlayer : bool = false

func damage(attack : Attack):
	if healthComponent:
		healthComponent.damage(attack)
	if damageFlashComponent:
		damageFlashComponent.flash()
		
func heal(healthToHeal : int):
	if healthComponent:
		healthComponent.heal(healthToHeal)
