extends Control

@onready var redlabel = $Dust

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.game_stats_changed.connect(_on_game_stats_changed)
	update_stats()


#Angry face this should not be in the HUD!!!!!

#Replace with this
func _on_game_stats_changed():
	update_stats()


func update_stats():
	redlabel.text = "Red Dust: " + str(GameManager.red_dust_collected)

	
