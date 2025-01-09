extends Node
#Tutorial-damen vil at man skal kunne increase antall slots, men jeg vet ikke helt...
#Jeg syns ikke det å begrense inventoryen virker gøy i dette tilfellet.

var inventory = []
var inventory_size = 30
var player_node: Node = null #Vet ikke hvorfor vi trenger dette.

signal inventory_updated #To signal to the UI



func _ready():
	inventory.resize(inventory_size) #30 slots, spread over 9 per row
	print(inventory)

func check_not_full():
	if inventory[inventory_size - 1] == null:
		return true
	else:
		return false

func add_item(item):
	if inventory[(inventory_size - 1)] == null:
		print("Available inventory")
		if item["type"] == "star":
			inventory.push_front(item) #Nå kommer nye items først, heller enn sist. Kan endres.
			inventory.pop_back()
		else:
			for i in range(inventory.size()):
				if inventory[i] != null and inventory[i]["type"] == item["type"] and inventory[i]["name"] == item["name"]:
					print("should have increased quantity")
					inventory[i]["quantity"] += item["quantity"]
					break
				elif inventory[i] == null:
					print("should have added item")
					inventory.push_front(item)
					inventory.pop_back()
					break
	emit_signal("inventory_updated") #TODO update UI to match changes

func remove_item(item):
	emit_signal("inventory_updated")

func set_player_reference(player):
	player_node = player
	#Vet ikke hvorfor vi trenger dette...
	
