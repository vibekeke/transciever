extends Area2D
class_name InteractionArea


@export var action_name: String = "interact"
@export var arrow_location: int = 20

@onready var arrow = $Arrow

var interact: Callable = func():
	pass
	
	#Callable gjør at alle ting som inheriter fra klassen kan bruke denne funksjonen, 
	#men override den med en helt annen funksjon. Elns, skjønte ikke helt.


func _ready() -> void:
	arrow.position.y -= arrow_location
	arrow.hide()

func _process(delta):
	if InteractionManager.active_areas.size() > 0:
		if InteractionManager.active_areas[0] == self:
			arrow.show()
		else:
			arrow.hide()

func _on_body_entered(body: Node2D) -> void:
	InteractionManager.register_area(self)


func _on_body_exited(body: Node2D) -> void:
	InteractionManager.unregister_area(self)


	
