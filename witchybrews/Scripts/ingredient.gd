extends Control
class_name Ingredient

@export var operation:DragData.Operation

@export var energy:bool
@export var smell:bool
@export var ghostyness:bool
@export var confidence:bool
@export var looks:bool
@export var luck:bool
@export var mood:bool
@export var moisture:bool
@export var baptizm:bool

func getValue():
	var value:int = 0
	if energy: value |= 1 << 0
	if smell: value |= 1 << 1
	if ghostyness: value |= 1 << 2
	if confidence: value |= 1 << 3
	if looks: value |= 1 << 4
	if luck: value |= 1 << 5
	if mood: value |= 1 << 6
	if moisture: value |= 1 << 7
	if baptizm: value |= 1 << 8
	return value

func _get_drag_data(at_position:Vector2)->Variant:
	set_drag_preview(get_node("Graphic").duplicate())
	return DragData.new(DragData.DragType.INGREDIENT, getValue(), operation)
