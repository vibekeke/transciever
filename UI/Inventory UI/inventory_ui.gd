extends Control

var inventory_open = false
@onready var grid_container = $PanelContainer/MarginContainer/VBoxContainer/GridContainer



func _ready() -> void:
	InventoryManager.inventory_updated.connect(_on_inventory_updated)
	hide()

func _input(event):
	if event.is_action_pressed("ui_inventory"):
		if inventory_open == true:
			exit_inventory()
		elif Global.move_enabled and InteractionManager.can_interact:
			open_inventory()
				


func open_inventory():
	Global.move_enabled = false
	InteractionManager.can_interact = false
	inventory_open = true
	await _wait_for_input_release()
	show()
	#Grab correct focus and whatnot.

func _wait_for_input_release():
	while Input.is_action_just_pressed("ui_accept"):
		await get_tree().process_frame

func exit_inventory():
	inventory_open = false
	Global.move_enabled = true
	InteractionManager.can_interact = true
	hide()



func _on_inventory_updated():
	clear_grid_container()
	print("inventory 'updated!'")
	
#Important to clear our grid and release stuff from memory before updating, or something...
func clear_grid_container():
	while grid_container.get_child_count() > 0:
		var child = grid_container.get_child(0)
		grid_container.remove_child(child)
		child.queue_free()
