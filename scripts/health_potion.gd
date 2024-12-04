extends Node2D

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@export var healingAmount : int = 2

func _on_hit_box_component_area_entered(area: Area2D) -> void:
	if area is HitBoxComponent:
		var hitBox : HitBoxComponent = area
		hitBox.heal(healingAmount)
		var tween = get_tree().create_tween()
		tween.tween_property(sprite, "modulate:a", 0, 0.5).finished
		queue_free()
