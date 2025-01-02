extends Node2D

@export var spawnable_scene : PackedScene
@export var spawn_frequency = 1


func _ready():
	$SpawnTimer.start(spawn_frequency)


func _on_spawn_timer_timeout() -> void:
	var spawned_object = spawnable_scene.instantiate()
	spawned_object.position = position
	
	get_parent().add_child(spawned_object)
