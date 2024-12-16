extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var dash_cooldown = $DashCooldown

@export var player_speed = 200
@export var friction = 0.5

var rotation_velocity = 10.0  # Starting speed of rotation
var max_rotation_velocity = 100.0     # Max speed for rotation
var rot_acceleration = 500.0      # How quickly it accelerates
var rot_deceleration = 230.0       # How quickly it decelerates

@export var dash_speed = 800
var dash_direction = Vector2()
var can_dash = true

signal just_dashed(direction)
signal dash_finished


func _physics_process(delta: float) -> void:
	# Accelerate the rotation speed when holding the button
	var direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	
	#Dash
	
	#Movement
	direction = direction.normalized()
	velocity = velocity.lerp(direction * player_speed, 0.1)
	velocity *= 1-0 -(friction * delta)
	
	move_and_slide()
	
	#Dash
	if Input.is_action_just_pressed("dash") and can_dash:
		can_dash = false
		dash_cooldown.start()
		dash_direction = direction.normalized()
		velocity = dash_direction * dash_speed
		velocity *= 1.0 - (friction * delta)
		emit_signal("just_dashed", dash_direction * dash_speed)
	
	#Rotation
	if velocity.x < -50 or velocity.x > 50:
		rotation_velocity += velocity.x 
	elif velocity.y < -50 or velocity.y > 50:
		rotation_velocity += velocity.y
	else:
		# Gradually slow down the rotation when velocity is closer to 0
		if rotation_velocity > 30:
			rotation_velocity -= (rot_deceleration) * delta
		elif rotation_velocity < -30:
			rotation_velocity += (rot_deceleration) * delta
	# Clamp the rotation speed to max velocity
	
	rotation_velocity = clamp(rotation_velocity, (-max_rotation_velocity / (scale.x * 1.5)), (max_rotation_velocity / (scale.x * 1.5)))
	# Apply the rotation velocity to the sprite's rotation
	sprite.rotation_degrees += rotation_velocity * delta
	sprite.rotation_degrees = fmod(sprite.rotation_degrees, 360)


func _on_dash_cooldown_timeout() -> void:
	can_dash = true
	emit_signal("dash_finished")
