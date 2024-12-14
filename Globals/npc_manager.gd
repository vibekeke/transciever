extends Node

class_name NPCManager

var chara = "failedpc"
var dialogue = "FailedPC"

var npc_list : Array[String] = []
#Vet ikke hvorfor men export var funka ikke veldig kult.

var FailedPC = load("res://NPC/nps/failedpc.tscn").instantiate() #Do not add him to the list!
var Angel = load("res://NPC/nps/angel.tscn").instantiate()


func _ready():
	print("NPC Manager is ready!")
	#TODO: Lag en array med alle NPCsene til slutt
	
func call_someone():
	print("it worked probably")
	
	chara = find_someone()
	dialogue = chara.get_dialogue()
	start_conversation(dialogue[0], dialogue[1]) #Eventuelt også portrett? Vet ikke hvordan d funker.

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
	
#TODO Implementere den stygge løsningen til chatgpt
#func get_available_npcs() -> Array:
#	var available_npcs = []
#	for npc in npcs:
#		if npc.available:
#			available_npcs.append(npc)
#			return available_npcs
