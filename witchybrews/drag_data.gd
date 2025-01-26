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
			modifiedValue &= 511 #mask to just the first 9 bits
		Operation.SHIFT_LEFT:
			var wasRightmostBitSet = (inValue & 256) > 0
			modifiedValue = inValue << 1
			modifiedValue &= 510 #mask just the bits that moved
			if(wasRightmostBitSet): modifiedValue += 1 #move the bit from the end to the other side
		Operation.SHIFT_RIGHT:
			var wasLeftmostBitSet = (inValue & 1) > 0
			modifiedValue = inValue >> 1
			modifiedValue &= 255 #mask just the bits that moved
			if(wasLeftmostBitSet): modifiedValue += 256 #move the bit from the end to the other side
		Operation.AND:
			modifiedValue = inValue & value
		Operation.OR:
			modifiedValue = inValue | value
		Operation.XOR:
			modifiedValue = inValue ^ value
		_:
			pass
	return modifiedValue
