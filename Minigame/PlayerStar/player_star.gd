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

@export var dash_speed = 800
var dash_direction = Vector2()
var can_dash = true

signal just_dashed(direction)
signal dash_finished

var red_intensity: float = 0.0
var green_intensity: float = 0.0
var blue_intensity: float = 0.0
var light_energy = 1.0

var color_increase = 0.01
var light_increase = 0.05
var size_increase = 0.005

var max_red = 1.0 #Might differ from the actual shader max-values, but good to clamp anyways.
var max_green = 0.60
var max_blue = 0.65

var star_size = 0.2
var max_star_size = 2.0

func _ready():
	GameManager.collectible_collected.connect(_on_collectible_collected)
	
	sprite.material.set_shader_parameter("red_intensity", red_intensity)
	sprite.material.set_shader_parameter("blue_intensity", blue_intensity)
	sprite.material.set_shader_parameter("green_intensity", green_intensity)
	
	scale = Vector2(star_size, star_size)
	
	point_light.energy = light_energy
	
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

func _on_collectible_collected(collectible, amount):
	#Changing variables:
	match collectible:
		"red_dust":
			red_intensity += color_increase * amount  # Increase red intensity
			blue_intensity -= (color_increase/4) * amount
			green_intensity -= (color_increase/4) * amount
		"blue_dust":
			blue_intensity += color_increase * amount
			green_intensity -= (color_increase/4) * amount
			red_intensity -= (color_increase/4) * amount
		"green_dust":
			green_intensity += color_increase * amount
			red_intensity -= (color_increase/4) * amount
			blue_intensity -= (color_increase/4) * amount
		"white_dust":
			red_intensity += color_increase * 3
			blue_intensity += color_increase * 3
			green_intensity += color_increase * 3
	
	light_energy += light_increase * amount
	star_size += size_increase * amount
	
	
	# Clamp intensity values to prevent them from going beyond the max value (0.7 in your case)
	red_intensity = clamp(red_intensity, 0.0, max_red)
	green_intensity = clamp(green_intensity, 0.0, max_green)
	blue_intensity = clamp(blue_intensity, 0.0, max_blue)
	
	star_size = clamp(star_size, 0.0, max_star_size)
	light_energy = clamp(light_energy, 0.0, 8.0)
	
	#Updating visuals according to variables
	scale = Vector2(star_size, star_size)
	sprite.material.set_shader_parameter("red_intensity", red_intensity)
	sprite.material.set_shader_parameter("blue_intensity", blue_intensity)
	sprite.material.set_shader_parameter("green_intensity", green_intensity)
	
	point_light.energy = light_energy
	print("Red_intensity: " + str(red_intensity))
	print("Blue_intensity: " + str(blue_intensity))
	print("Green_intensity: " +  str(green_intensity))
	#print("Light_energy: " + str(light_energy))
