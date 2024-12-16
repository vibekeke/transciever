extends Area2D

var speed = 100
var rotation_speed = 50
@onready var sprite = $Sprite2D
@onready var speed_multiplier = randi_range(15, 25)
var collected_value = 1

func _ready() -> void:
	speed_multiplier = speed_multiplier / 10
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= GameManager.global_speed * speed_multiplier * delta
	
	
	sprite.rotation_degrees -= rotation_speed * delta
	sprite.rotation_degrees = fmod(sprite.rotation_degrees, 360)
	
	if position.y < -10:
		print("deleting self")
		queue_free()
		

func _on_body_entered(body: Node2D) -> void:
	GameManager.emit_signal("collectible_collected", "RedDust", collected_value)
	print("collected")
	queue_free()
