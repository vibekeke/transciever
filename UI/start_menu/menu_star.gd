extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var dash_cooldown = $DashCooldown
@onready var point_light = $PointLight2D

@export var player_speed = 300
@export var friction = 0

var rotation_velocity = 10.0  # Starting speed of rotation
var max_rotation_velocity = 100.0     # Max speed for rotation
var rot_acceleration = 500.0      # How quickly it accelerates
var rot_deceleration = 230.0       # How quickly it decelerates


var red_intensity: float = 1.0
var green_intensity: float = 1.0
var blue_intensity: float = 1.0
var light_energy = 1.0

func _ready():
	sprite.material.set_shader_parameter("red_intensity", red_intensity)
	sprite.material.set_shader_parameter("blue_intensity", blue_intensity)
	sprite.material.set_shader_parameter("green_intensity", green_intensity)
	
	point_light.energy = light_energy
	
func _physics_process(delta: float) -> void:
	#TODO: Replace with position of focused button.
	var direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	
	#Dash
	
	#Movement
	direction = direction.normalized()
	velocity = velocity.lerp(direction * player_speed, 0.1)
	velocity *= 1-0 -(friction * delta)
	
	move_and_slide()
	
	
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
