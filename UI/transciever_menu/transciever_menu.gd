extends Control

@onready var call_button = $PanelContainer/MarginContainer/VBoxContainer/Button_Call
@onready var contacts_button = $PanelContainer/MarginContainer/VBoxContainer/Button_Contacts
@onready var starnetwork_button = $PanelContainer/MarginContainer/VBoxContainer/Button_StarNetwork
@onready var exit_button = $PanelContainer/MarginContainer/VBoxContainer/Button_Exit


var menu_open = false
signal tranciever_finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

func open_menu():
	Global.move_enabled = false
	menu_open = true
	await _wait_for_input_release()
	show()
	call_button.grab_focus()
	

func _wait_for_input_release():
	while Input.is_action_just_pressed("ui_accept"):
		await get_tree().process_frame

func exit_menu():
	menu_open = false
	finish_transciever()		#Avslutter alt med trancieveren
	hide()

func finish_transciever():
	emit_signal("tranciever_finished")
	Global.move_enabled = true


#Sikkert en cleanere måte å gjøre dette men hvem bryr seg lmao
func _on_button_call_mouse_entered() -> void:
	call_button.grab_focus()
func _on_button_contacts_mouse_entered() -> void:
	contacts_button.grab_focus()
func _on_button_star_network_mouse_entered() -> void:
	starnetwork_button.grab_focus()
func _on_button_exit_mouse_entered() -> void:
	exit_button.grab_focus()



func _on_button_call_pressed() -> void:
	print("Made a phonecall!")
	hide()
	
	NpcManager.call_someone()
	await DialogueManager.dialogue_ended
	#DialogueManager.show_dialogue_balloon(load("res://Dialogue/dialogue.dialogue"), "this_is_a_node_title")
	finish_transciever()

func _on_button_contacts_pressed() -> void:
	print("Opened Contacts!")

func _on_button_star_network_pressed() -> void:
	print("Opened Star Network!")

func _on_button_exit_pressed() -> void:
	exit_menu() #Will also finish_ransciever()
