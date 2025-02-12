extends Node2D


var npc_name = "ch_FailedPC"
var available = true



var relationship = 100
var dialogue = "A"

var onetime_dialogue = ["old_man", "zoom"]
var repeatable_dialogue = ["crack", "vinyl", "pop", "doop"]

func get_dialogue():
	if len(onetime_dialogue) < 1:
		dialogue = repeatable_dialogue.pick_random()
	else: 
		var chosen = onetime_dialogue.pick_random() #Returns a string
		dialogue = chosen
		onetime_dialogue.erase(chosen)
	return [npc_name, dialogue]
	
	
	
	
