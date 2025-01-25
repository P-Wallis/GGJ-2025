extends Node
class_name DragData

enum DragType {NONE, POTION, INGREDIENT}
enum Operation { NOOP, RESET, INVERT, SHIFT_LEFT, SHIFT_RIGHT, AND, OR, XOR }

@export var type:DragType
@export var value:int
@export var operation:Operation

func _init(dragType:DragType = DragType.NONE, dragValue:int = 0, dragOperation:Operation = Operation.XOR):
	type = dragType
	value = dragValue
	operation = dragOperation
	
func ModifyInputValue(inValue:int):
	var modifiedValue:int = inValue
	match(operation):
		Operation.RESET:
			modifiedValue = 0
		Operation.INVERT:
			modifiedValue = ~inValue
		Operation.SHIFT_LEFT:
			modifiedValue = inValue << 1
		Operation.SHIFT_RIGHT:
			modifiedValue = inValue >> 1
		Operation.AND:
			modifiedValue = inValue & value
		Operation.OR:
			modifiedValue = inValue | value
		Operation.XOR:
			modifiedValue = inValue ^ value
		_:
			pass
	return modifiedValue
