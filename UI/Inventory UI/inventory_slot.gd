extends Control

#TODO: Godots broken ass UI input bullshit isn't prioritizing the UsagePanel. Idk how to fix it, tried everything
#Maybe the tutorial handles it later, but fuckit, I'm out of here.

#Item information
@onready var icon = $MarginContainer/PanelContainer/ItemIcon
@onready var quantity_label = $MarginContainer/PanelContainer/ItemQuantity
@onready var inspect_button = $UsagePanel/MarginContainer/VBoxContainer/InspectButton
@onready var drop_button = $UsagePanel/MarginContainer/VBoxContainer/DropButton
@onready var cancel_button = $UsagePanel/MarginContainer/VBoxContainer/CancelButton
@onready var item_name = $DetailsPanel/MarginContainer/VBoxContainer/ItemName
@onready var item_attribute_1 = $DetailsPanel/MarginContainer/VBoxContainer/ItemAttribute1
@onready var item_attribute_2 = $DetailsPanel/MarginContainer/VBoxContainer/ItemAttribute2

#Buttons
@onready var item_button = $MarginContainer/ItemButton

@onready var usage_panel = $UsagePanel
@onready var details_panel = $DetailsPanel

#Slot item
var item = "Cake"

var usage_panel_open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	usage_panel.hide()
	details_panel.hide()
	InventoryManager.focus_toggled.connect(_on_focus_toggled)
	
	item_button.connect("gui_input", Callable(self, "_on_item_button_gui_input"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_focus_toggled():
	if InventoryManager.focus_enabled:
		item_button.disabled = false
		item_button.focus_mode = Control.FOCUS_ALL
		item_button.mouse_filter = Control.MOUSE_FILTER_PASS
	else:
		item_button.disabled = true
		item_button.focus_mode = Control.FOCUS_NONE
		item_button.mouse_filter = Control.MOUSE_FILTER_IGNORE

'
func _on_item_button_gui_input(event: InputEvent):
	if item_button.disabled and event is InputEventMouseButton and event.pressed:
		event.set_handled()
'

func _on_item_button_pressed() -> void:
	if usage_panel_open:
		usage_panel.hide()
		details_panel.show()
		InventoryManager.enable_focus()
		usage_panel_open = false
	elif item != null and InventoryManager.focus_enabled:
		details_panel.hide()
		usage_panel.show()
		InventoryManager.disable_focus()
		usage_panel_open = true


func _on_item_button_focus_exited() -> void:
	print("Focus exited")
	details_panel.hide()


func _on_item_button_focus_entered() -> void:
	if item != null and InventoryManager.focus_enabled:
		details_panel.show()
		print("Focus entered")


func _on_item_button_mouse_entered() -> void:
	if InventoryManager.focus_enabled:
		item_button.grab_focus() #TODO: Når man åpner menyen er ingenting valgt, før brukeren trykker en piltast.
		print("Mouse entered")

func _on_item_button_mouse_exited() -> void:
	if InventoryManager.focus_enabled:
		item_button.release_focus()
		print("Mouse exited")
