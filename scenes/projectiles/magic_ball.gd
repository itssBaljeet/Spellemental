extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP
func _ready():
	look_at(get_global_mouse_position())

func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if body.name == "Player":
		return
	speed = 0
	$"Ball Sprite".hide()
	$ExplosionAnimation.show()
	$ExplosionAnimation.play("default")
	var tween = get_tree().create_tween()
	await tween.tween_property(self, "modulate:a", 0, 1.0).finished
	queue_free()
