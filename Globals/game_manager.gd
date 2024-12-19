extends Node

var global_speed = 50
signal collectible_collected(collectible, amount)
signal game_stats_changed


var red_dust_collected = 0

func _ready():
	GameManager.collectible_collected.connect(_on_collectible_collected)

func _on_collectible_collected(collectible, amount):
	match collectible:
		"red_dust":
			red_dust_collected += amount
	
	emit_signal("game_stats_changed")
