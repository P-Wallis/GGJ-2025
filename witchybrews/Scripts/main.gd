extends Control
class_name Main

@onready var dialoguePanel:Control = get_node("DialoguePanel")
@onready var dialogueLabel:Label = get_node("DialoguePanel/DialogueLabel")

@export var person:Person
func _ready() -> void:
	person.initialize(self)
	start()

var difficulty:Person.difficulty = Person.difficulty.VERY_EASY
func start():
	person.generateNewState(difficulty)
	var names = ["Winefred", "Suzie", "Mice", "Sugar"]
	var randomName = names[randi_range(0,names.size()-1)]
	var dialogue:String = "Hey, I'm " + randomName +"! I'm hoping you can help me with something... I'd like to:" +person.getDesireList()
	showDialogue(dialogue)

func end():
	person.visible = false
	showDialogue("Nice work! No more customers today")

func showDialogue(text:String):
	dialoguePanel.visible = true
	dialogueLabel.text = text
	
func success():
	if(difficulty != Person.difficulty.HARD):
		difficulty += 1
		start()
		return
	end()
