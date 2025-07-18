extends Node

var global_speed = 50
signal collectible_collected(collectible, amount)
signal game_stats_changed
signal health_decreased(new_health)


var red_dust_collected = 0
var blue_dust_collected = 0
var green_dust_collected = 0
var health = 3

func _ready():
	GameManager.collectible_collected.connect(_on_collectible_collected)

func _on_collectible_collected(collectible, amount):
	match collectible:
		"red_dust":
			red_dust_collected += amount
		"blue_dust":
			blue_dust_collected += amount
		"green_dust":
			green_dust_collected += amount
	
	emit_signal("game_stats_changed")

func decrease_health():
	if health <= 1: #last life decreased
		game_over()
	else:
		health -= 1
		emit_signal("health_decreased", health)

func game_over():
	#TODO: Frys player movement / knus stjerneanimasjon
	# Lag ny game-over meny, med stats
	# Lag overgangen fra minispill til overworld
	print("game_over lol")
