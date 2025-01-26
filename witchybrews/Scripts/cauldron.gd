extends Control
class_name Cauldron

@export var mugDragObject:PackedScene
var currentValue:int = 0

@onready var energy:Control = get_node("HBoxContainer/Alertness")
@onready var smell:Control = get_node("HBoxContainer/Smell")
@onready var ghostyness:Control = get_node("HBoxContainer/Hauntedness")
@onready var confidence:Control = get_node("HBoxContainer/Confidence")
@onready var looks:Control = get_node("HBoxContainer/Looks")
@onready var luck:Control = get_node("HBoxContainer/Luck")
@onready var mood:Control = get_node("HBoxContainer/Mood")
@onready var moisture:Control = get_node("HBoxContainer/Moisture")
@onready var baptism:Control = get_node("HBoxContainer/Baptism")

func getControlFromInt(value:int):
	match(value):
		0:
			return energy
		1:
			return smell
		2:
			return ghostyness
		3:
			return confidence
		4:
			return looks
		5:
			return luck
		6:
			return mood
		7:
			return moisture
		8:
			return baptism
		_:
			return null

func _ready():
	updateBubbles(0)

func _get_drag_data(at_position:Vector2)->Variant:
	var drag_data = DragData.new(DragData.DragType.POTION, currentValue)
	set_drag_preview(mugDragObject.instantiate())
	return drag_data

func _can_drop_data(at_position:Vector2, data:Variant)->bool:
	if !data is DragData: return false
	var drag_data := data as DragData
	return drag_data.type == DragData.DragType.INGREDIENT #only allow ingredients

func _drop_data(at_position:Vector2, data:Variant)->void:
	var drag_data := data as DragData
	currentValue = drag_data.ModifyInputValue(currentValue)
	updateBubbles(currentValue)
	
func updateBubbles(value:int):
	var power:int = 1
	var control:Control
	for p in 9:
		control = getControlFromInt(p)
		control.visible = (value & power) > 0
		power *= 2
