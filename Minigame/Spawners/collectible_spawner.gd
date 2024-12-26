extends Node2D

@export var collectible_scene : PackedScene
@export var spawn_frequency = 1


func _ready():
	$SpawnTimer.start(spawn_frequency)


func _on_spawn_timer_timeout() -> void:
	var collectible = collectible_scene.instantiate()
	collectible.position = position
	
	get_parent().add_child(collectible)
