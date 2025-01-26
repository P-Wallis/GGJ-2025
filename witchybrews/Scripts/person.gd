extends Control

var currentValue:int = 0

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

func _ready():
	updateState(0)

func _can_drop_data(at_position:Vector2, data:Variant)->bool:
	if !data is DragData: return false
	var drag_data := data as DragData
	return drag_data.type == DragData.DragType.POTION #only allow potions

func _drop_data(at_position:Vector2, data:Variant)->void:
	var drag_data := data as DragData
	updateState(drag_data.ModifyInputValue(currentValue))
	
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
