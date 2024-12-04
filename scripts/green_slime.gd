extends CharacterBody2D

var canJump = false
var playerPos : Vector2
var direction = Vector2.LEFT
@export var SPEED = 100.0

@onready var airTimeTimer = $AirTimeTimer
@onready var jumpTimer = $JumpTimer
@onready var sprite = $AnimatedSprite2D


func _ready() -> void:
	jumpTimer.wait_time = randi_range(2, 5)
	jumpTimer.start()
	
func _process(delta: float) -> void:
	if canJump:
		sprite.animation = "jump"
		velocity = SPEED * (playerPos - position).normalized()
		move_and_slide()
	else:
		sprite.animation = "idle"
	
	var direction = (playerPos - position).normalized().x

	if direction < 0:
		sprite.flip_h = true
	elif direction > 0:
		sprite.flip_h = false
	

func _on_air_time_timer_timeout() -> void:
	canJump = false
	jumpTimer.wait_time = randi_range(2, 5)
	jumpTimer.start()


func _on_jump_timer_timeout() -> void:
	canJump = true
	airTimeTimer.start()


func _on_player_handpos(pos: Variant) -> void:
	playerPos = pos
