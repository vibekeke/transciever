extends Node

class_name NPCManager

var chara = "failedpc"
var dialogue = "FailedPC"

var npc_list : Array[String] = []
#Vet ikke hvorfor men export var funka ikke veldig kult.
var call_history = []

var FailedPC = load("res://NPC/nps/failedpc.tscn").instantiate() #Do not add him to the list!
var Angel = load("res://NPC/nps/angel.tscn").instantiate()


func _ready():
	print("NPC Manager is ready!")
	#TODO: Lag en array med alle NPCsene til slutt

func get_available():
	#TODO: for everyone in NPC-list, get available status and create list OR update a dict. dunno yet.
	pass

func call_someone():
	print("it worked probably")
	
	chara = find_someone()
	dialogue = chara.get_dialogue()
	start_conversation(dialogue[0], dialogue[1]) #Eventuelt også portrett? Vet ikke hvordan d funker.
	call_history.push_front(chara)
	

func find_someone():
	#TODO: Lag logikk for å finne noen.
	#I starten, random karakter, med høy frekvens av FailedPC
	#Senere, lavere frekvens av FailedPC.
	#Hvis alle er ferdige -> FailedPC
	#Midlertidig fordi vi bare har en karakter lol:
	return FailedPC

func start_conversation(filename, dialogue):
	var balloon = preload("res://Dialogue/balloon.tscn").instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(load("res://Dialogue/" + filename + ".dialogue"), dialogue)

func update_NPC_status():
	#TODO: For all NPCs, update various necessary stats: Everyones annoyance, availability etc.
	#Vet ikke hva logikken skal være enda.
	pass
