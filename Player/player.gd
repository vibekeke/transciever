extends CharacterBody2D

#TODO redo all animasjon og bevegelse lmao, vi må bare komme oss til ny content

var direction
var preferred_anim = "_down"
var move_speed = 250 #Slett kanskje
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var all_interactions = []



func _physics_process(delta: float) -> void:
	direction = Vector2.ZERO
	
	if Global.move_enabled:
		if Input.is_action_pressed("ui_right"):
			direction.x += 1
		if Input.is_action_pressed("ui_left"):
			direction.x -= 1
		if Input.is_action_pressed("ui_down"):
			direction.y += 1
		if Input.is_action_pressed("ui_up"):
			direction.y -= 1
		
	#kalkulerer sterkeste retning for å bestemme animasjon:	
	if direction.x > 0 and direction.y == 0:
		preferred_anim = "_right"
		animated_sprite_2d.flip_h = false
	elif direction.x < 0 and direction.y == 0:
		preferred_anim = "_right"
		animated_sprite_2d.flip_h = true
	elif direction.y > 0 and direction.x == 0:
		preferred_anim = "_down"
	elif direction.y < 0 and direction.x == 0:
		preferred_anim = "_up"
	
	direction = direction.normalized()
	velocity = direction * move_speed
	move_and_slide()

	#Bestemmer animasjon
	if velocity.length() > 100:
		animated_sprite_2d.play("walk"+preferred_anim)
	else:
		animated_sprite_2d.play("idle"+preferred_anim)
