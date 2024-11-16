extends CharacterBody2D

var direction: Vector2 = Vector2.LEFT
var playerPos: Vector2

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
