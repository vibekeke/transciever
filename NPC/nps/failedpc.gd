extends Node2D


var npc_name = "FailedPC"
var relationship = 100
var dialogue = "A"

var onetime_dialogue = ["old_man", "zoom"]
var repeatable_dialogue = ["crack", "vinyl", "pop", "doop"]

func get_dialogue():
	if len(onetime_dialogue) < 1:
		dialogue = repeatable_dialogue[randi_range(0, (len(repeatable_dialogue) - 1))]
	else: 
		var chosen = randi_range(0, (len(onetime_dialogue) - 1))
		dialogue = onetime_dialogue[chosen]
		onetime_dialogue.remove_at(chosen)
	return [npc_name, dialogue]
	
	
	
	
