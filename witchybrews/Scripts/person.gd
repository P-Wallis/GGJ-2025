extends Control
class_name Person

@export var graphicsRoot:Control
@export var tiredEyes:Control
@export var alertEyes:Control
@export var timidBrows:Control
@export var confidentBrows:Control
@export var smile:Control
@export var frown:Control
@export var nose:Control
@export var stink:Control
@export var halo:Control
@export var horns:Control
@export var damp:Control
@export var shamrock:Control
@export var skull:Control
@export var ghost:Control
	
var desiredValue:int
var careFlags:int
var currentValue:int

enum difficulty {VERY_EASY, EASY, MEDIUM, HARD}

func _ready():
	updateState(0)

var main
func initialize(inMain:Main):
	main = inMain

func getDesireList():
	var list = ""
	var power:int = 1
	var control:Control
	for p in 9:
		var cares:bool = (careFlags & power) > 0
		if(cares):
			match p:
				0:
					list += "\n - Be Alert"
				1:
					list += "\n - Smell Better"
				2:
					list += "\n - Not Be Haunted"
				3:
					list += "\n - Be Confident"
				4:
					list += "\n - Look Better"
				5:
					list += "\n - Be Lucky"
				6:
					list += "\n - Be Happier"
				7:
					list += "\n - Be Dry"
				8:
					list += "\n - Be Baptized"
		power *= 2
	return list
	
func generateNewState(dif:difficulty):
	var numStateChangesDesired:int = 1
	var numStateChangesCared:int = 1
	match (dif):
		difficulty.EASY:
			numStateChangesDesired=2
			numStateChangesCared=2
		difficulty.MEDIUM:
			numStateChangesDesired=2
			numStateChangesCared=3
		difficulty.HARD:
			numStateChangesDesired=3
			numStateChangesCared=4
	
	var careItems = []
	var power = 1
	for p in 9:
		careItems.insert(randi_range(0,careItems.size()), power)
		power *= 2
	
	careFlags = 0
	for c in numStateChangesCared:
		careFlags |= careItems[c]
		
	var desiredFlags = 0
	for d in numStateChangesDesired:
		desiredFlags |= careItems[d]
		
	currentValue = (randi_range(1,511) & (~careFlags)) | desiredFlags
	desiredValue = currentValue & (~desiredFlags)
	
	updateState(currentValue)
	

func isDone():
	var current:int = careFlags & currentValue
	var desired:int = careFlags & desiredValue
	return current == desired

func _can_drop_data(at_position:Vector2, data:Variant)->bool:
	if !data is DragData: return false
	var drag_data := data as DragData
	return drag_data.type == DragData.DragType.POTION #only allow potions

func _drop_data(at_position:Vector2, data:Variant)->void:
	var drag_data := data as DragData
	updateState(drag_data.ModifyInputValue(currentValue))
	if(isDone()):
		main.success()
	
func updateState(value:int):
	currentValue = value
	print("SetState: " +str(value))
	var power:int = 1
	var control:Control
	for p in 9:
		var isInBadState:bool = (value & power) > 0
		power *= 2
		match (p):
			0:
				tiredEyes.visible = isInBadState
				alertEyes.visible = !isInBadState
			1:
				stink.visible = isInBadState
			2:
				ghost.visible = isInBadState
			3:
				timidBrows.visible = isInBadState
				confidentBrows.visible = !isInBadState
			4:
				nose.visible = !isInBadState
			5:
				skull.visible = isInBadState
				shamrock.visible = !isInBadState
			6:
				frown.visible = isInBadState
				smile.visible = !isInBadState
			7:
				damp.visible = isInBadState
			8:
				horns.visible = isInBadState
				halo.visible = !isInBadState
