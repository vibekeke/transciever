extends Area2D
class_name InteractionArea


@export var action_name: String = "interact"
@export var arrow_location: int = 15 #Kan hende vi ditcher denne variabelen senere, y-sort ser ut til å være linket til parent uansett

@onready var arrow = $Arrow
var arrow_visible: bool

var interact: Callable = func():
	pass
	#Callable gjør at alle ting som inheriter fra klassen kan bruke denne funksjonen, 
	#men override den med en helt annen funksjon. Elns, skjønte ikke helt.

var initial_position = Vector2()
var bobbing_amplitude = 8
var bobbing_speed = 2
var bobbing_time = 0
var rotation_velocity = 0.2 #tenkte det var litt cute med stjerne, men idk

func _ready() -> void:
	arrow.position.y -= arrow_location
	initial_position = arrow.position
	
	arrow.hide()
	arrow_visible = false

func _process(delta):
	if arrow_visible == true:
		bobbing_time += delta * bobbing_speed
		arrow.position.y = initial_position.y + bobbing_amplitude * sin(bobbing_time)
		
		arrow.rotation_degrees += rotation_velocity
	else:
		arrow.position.y = initial_position.y
	
		
	if InteractionManager.active_areas.size() > 0:
		if InteractionManager.active_areas[0] == self and Global.move_enabled:
			arrow.show()
			arrow_visible = true
		else:
			arrow.hide()
			arrow_visible = false

func _on_body_entered(body: Node2D) -> void:
	InteractionManager.register_area(self)


func _on_body_exited(body: Node2D) -> void:
	InteractionManager.unregister_area(self)


	
