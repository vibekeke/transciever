extends Area2D

#TODO: Create a class so we can change code quickly and because it makes you a cool programmer

var speed = 100
var rotation_speed = 50
@onready var sprite = $AnimatedSprite2D
var speed_multiplier = 1
var collected_value = 1

func _ready() -> void:
	randomize()
	speed_multiplier = randf_range(1.0, 2.5)
	sprite.rotation_degrees = randi_range(0, 50)
	sprite.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speed = GameManager.global_speed * speed_multiplier
	position.y -= speed * delta
	
	
	sprite.rotation_degrees -= rotation_speed * delta
	sprite.rotation_degrees = fmod(sprite.rotation_degrees, 360)
	
	if position.y < -10:
		print("deleting self")
		queue_free()
		

func _on_body_entered(body: Node2D) -> void:
	GameManager.emit_signal("collectible_collected", "RedDust", collected_value)
	print("collected")
	queue_free()
