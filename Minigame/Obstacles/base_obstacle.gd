extends Area2D

var speed = 100
var rotation_speed = 50
var speed_multiplier = 1
var type = "obstacle"

@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	sprite.play()

func _process(delta: float) -> void:
	speed = GameManager.global_speed * speed_multiplier
	position.y -= speed * delta
	
	if position.y < -10:
		queue_free()
		

func _on_body_entered(body: Node2D) -> void:
	GameManager.decrease_health()
	print(GameManager.health)
	queue_free()
