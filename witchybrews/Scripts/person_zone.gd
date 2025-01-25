extends Panel

var currentValue:int = 1
@onready var label:Label = get_node("Label");

func _can_drop_data(at_position:Vector2, data:Variant)->bool:
	if !data is DragData: return false
	var drag_data := data as DragData
	return drag_data.type == DragData.DragType.POTION #only allow potions

func _drop_data(at_position:Vector2, data:Variant)->void:
	var drag_data := data as DragData
	currentValue = drag_data.ModifyInputValue(currentValue)
	label.text = str(currentValue);
