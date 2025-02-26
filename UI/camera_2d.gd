extends Camera2D

var zoom_speed = Vector2(0.1, 0.1)
var min_zoom = Vector2(0.5, 0.5)
var max_zoom = Vector2(1, 1)

var desired_zoom = zoom #initialize with original zoom level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	zoom = lerp(zoom, desired_zoom, 0.2)
	#TODO: Ease in and out for better gamefeel

	if Global.move_enabled:
		if Input.is_action_just_released("scroll up"):
			desired_zoom = clamp(zoom, min_zoom, max_zoom) + zoom_speed
		
		if Input.is_action_just_released("scroll down"):
			desired_zoom = clamp(zoom, min_zoom, max_zoom) - zoom_speed
