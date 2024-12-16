extends Control

@onready var redlabel = $Dust
var amount_collected = 0 #Delete this one, we are putting this in GameManager >:(

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.collectible_collected.connect(_on_collectible_collected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Angry face this should not be in the HUD!!!!!
func _on_collectible_collected(collectible, amount):
	amount_collected += amount
	redlabel.text = "Red Dust: " + str(amount_collected)
	print(collectible, amount)

#Replace with this
func _on_game_stats_changed():
	#Update the stats
	pass
