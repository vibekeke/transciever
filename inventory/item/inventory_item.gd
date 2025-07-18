extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea

@export var item_type: String
@export var item_name: String
@export var item_effect: String #Might remove later.
#Flere verdier kommer senere.
@export var item_texture: Texture

var scene_path: String = "res://Items and Inventory/Items/inventory_item.tscn"
#Vet ikke hva denne gjør.

@onready var sprite = $Sprite2D

#TODO: Sprites kan kanskje ende opp med litt forskjellige størrelser, så vi bør ha noen variabler til å ta høyde for det?

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		sprite.texture = item_texture
		#Gjør at ting ser riktig ut i editor, og ikke bare når man kjører spillet :3
	interaction_area.interact = Callable(self, "_on_pick_up") #Two arguments: self, and the name of the function we want
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		sprite.texture = item_texture

#Picking 
func _on_pick_up():
	var item = {
		"quantity": 1,
		"type" : item_type,
		"name" : item_name,
		"effect" : item_effect,
		"texture" : item_texture,
		"scene_path" : scene_path
	}
	if InventoryManager.check_not_full():
		print(InventoryManager.inventory)
		InventoryManager.add_item(item)
		self.queue_free()
	else:
		print("inventory full")
		#TODO Make dialogue balloon for player
