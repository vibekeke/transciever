extends Area2D
class_name InteractionArea

@export var action_name: String = "interact"

var interact: Callable = func():
	pass
	
	#Callable gjør at alle ting som inheriter fra klassen kan bruke denne funksjonen, 
	#men override den med en helt annen funksjon. Elns, skjønte ikke helt.


func _on_body_entered(body: Node2D) -> void:
	InteractionManager.register_area(self)


func _on_body_exited(body: Node2D) -> void:
	InteractionManager.unregister_area(self)
