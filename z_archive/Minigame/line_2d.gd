extends Line2D

@onready var playerstar = $"../PlayerStar"
@onready var rod_position = Vector2(playerstar.global_position.x, -1000)
var dash_active = false
var target_position = Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rod_position = rod_position.move_toward(Vector2(playerstar.global_position.x, -1000), 600 * delta)  # Speed of returning
	points = [Vector2(rod_position), playerstar.global_position]
	
	#Hvis du vil at starten av tråden skal være fixed
	#points = [Vector2(910, -1000), playerstar.global_position]

func _on_player_star_just_dashed(dash_velocity) -> void:
	#target_position = rod_position + (dash_velocity / 2)
	#rod_position = Vector2(target_position.x, -1000)
	#dash_active = true
	pass
func _on_player_star_dash_finished() -> void:
	#dash_active = false
	pass
