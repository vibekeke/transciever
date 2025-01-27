extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

const base_text = "[Space] to "

var active_areas = [] #This will hold all interactionareas that can now be interacted with.
#Items will register themselves here upon enter, and remove themselves when exited.
var can_interact = true

func register_area(area: InteractionArea):
	active_areas.push_back(area)	#appends an element to the end of an array

func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1: 	#Checks if the index exists in the array.
		active_areas.remove_at(index)	#If it exists, it will be removed.
		
func _process(delta):
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 100
		label.global_position.x -= label.size.x / 2
		label.show()
	else:
		label.hide()

func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_squared_to(area1.global_position)
	var area2_to_player = player.global_position.distance_squared_to(area2.global_position)
	return area1_to_player < area2_to_player
	
func _input(event):
	if Input.is_action_just_pressed("ui_accept") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call() #Kul greie.
			
			can_interact = true
