extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var TrancieverMenu = get_node("/root/Main/CanvasLayer/TranscieverMenu")

signal tranciever_interacted

func _ready():
	interaction_area.interact = Callable(self, "_on_interact") #Two arguments: self, and the name of the function we want


func _on_interact():
	print("Hey, we interacted!")
	emit_signal("tranciever_interacted")
	TrancieverMenu.open_menu()
	
	await TrancieverMenu.tranciever_finished
	#await Dialogmanager.dialogue_finished - et eksempel på signaler du kan lage og bruke
	#Alt dette er satt opp slik at hvis du er i en interaction, så kan du ikke accidentally interacte med noe annet
	#tror jeg.
