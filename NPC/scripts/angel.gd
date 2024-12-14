extends Node2D


#Vi skiller mellom variabler som er relevante for NPCmanager
var npc_name = "Angel"
var available = true


#Variabler som er relevante for karakteren
var relationship = 0
var unlocked_dialogue = ["Introduction"]

func get_dialogue():
	return [npc_name, unlocked_dialogue[0]]
