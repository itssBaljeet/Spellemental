extends Node2D

signal coinCollected()

func _on_area_2d_body_entered(body):
	print(body.name)
	
	if body.name == "Player":
		$CPUParticles2D.emitting = true
		var tween = get_tree().create_tween()
		await tween.tween_property(self, "modulate:a", 0, .75).finished
		Global.coin_count += 1
		queue_free()
