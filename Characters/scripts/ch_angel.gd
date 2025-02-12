extends Node2D


#Vi skiller mellom variabler som er relevante for NPCmanager
var npc_name = "Angel"
var available = true
var quests = []
var completed_quests = []

#Variabler som er relevante for karakteren
var annoyance = 0
var recent_events = [] #Hendelser som midlertidig påvirker dialog, i.e. "called_too_much"
var impressions = [] #Varige inntrykk av deg som person
var progression = 0		#Progresjonsteller, bare antall ganger dere har snakket elns.
var relationship = 0 	#Generell stat om hvor godt de liker deg?
var unlocked_dialogue = ["Introduction"]
var locked_dialogue = []


func get_dialogue():
	return [npc_name, unlocked_dialogue[0]]
