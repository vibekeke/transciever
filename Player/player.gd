extends CharacterBody2D

#TODO redo all animasjon og bevegelse lmao, vi må bare komme oss til ny content

var direction
var last_direction = "down"
var move_speed = 250
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var all_interactions = []


func _physics_process(delta: float) -> void:
	direction = Vector2.ZERO
	
	if Global.move_enabled:
		if Input.is_action_pressed("ui_left"):
			direction.x -= 1
			last_direction = "left"
		elif Input.is_action_pressed("ui_right"):
			direction.x += 1
			last_direction = "right"
		elif Input.is_action_pressed("ui_up"):
			direction.y -= 1
			last_direction = "up"
		elif Input.is_action_pressed("ui_down"):
			direction.y += 1
			last_direction = "down"
		else:
			stop_animation()
	
	direction = direction.normalized()
	velocity = direction * move_speed
	move_and_slide()

	if velocity.x == 0 and velocity.y == 0:
		stop_animation()
	elif direction.y < 0 and direction.x == 0:
		animated_sprite_2d.play("walk_up")
	elif direction.y > 0 and direction.x == 0:
		animated_sprite_2d.play("walk_down")
	elif direction.x > 0:
		animated_sprite_2d.play("walk_right")
		animated_sprite_2d.flip_h = false
	elif direction.x < 0:
		animated_sprite_2d.play("walk_right")
		animated_sprite_2d.flip_h = true
	

func stop_animation():
	if last_direction == "left":
		animated_sprite_2d.play("idle_right")
		animated_sprite_2d.flip_h = true
	if last_direction == "right":
		animated_sprite_2d.play("idle_right")
		animated_sprite_2d.flip_h = false
	if last_direction == "down":
		animated_sprite_2d.play("idle_down")
	if last_direction == "up":
		animated_sprite_2d.play("idle_up")
	
