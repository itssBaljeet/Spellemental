extends Area2D

@export var attack_damage : int = 1
@export var knockback_force : float

@export var speed: int = 250
var direction: Vector2 = Vector2.UP


func _ready():
	look_at(get_global_mouse_position())

func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if body.name == "Player":
		return
	explosion_animation()


func _on_hit_box_component_area_entered(area: Area2D) -> void:
	
	if area is HitBoxComponent:
		print("Found hitbox!")
		var hitBox : HitBoxComponent = area 
		
		var attack = Attack.new()
		attack.damage = attack_damage
		attack.knockback_force = knockback_force
		
		hitBox.damage(attack)
		explosion_animation()
		
func explosion_animation():
	speed = 0
	$"Ball Sprite".hide()
	$ExplosionAnimation.show()
	$ExplosionAnimation.play("default")
	var tween = get_tree().create_tween()
	await tween.tween_property(self, "modulate:a", 0, 1.0).finished
	queue_free()
