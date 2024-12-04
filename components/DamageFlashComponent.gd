extends Node2D
class_name DamageFlashComponent

@export var flash_color: Color = Color(1, 0, 0) # Flash color (e.g., red for damage)
@export var flash_duration: float = 0.1 # Duration of the flash effect
@export var flash_times: int = 2 # Number of times to flash
@export var sprite : AnimatedSprite2D

func _ready() -> void:
	if not sprite:
		push_error("Sprite node not found! Check sprite_node_path.")

# Call this method to trigger the flash effect
func flash() -> void:
	if sprite:
		for i in flash_times:
			sprite.modulate = flash_color
			await (get_tree().create_timer(flash_duration).timeout)
			sprite.modulate = Color(1, 1, 1) # Reset to normal color
			await (get_tree().create_timer(flash_duration).timeout)
