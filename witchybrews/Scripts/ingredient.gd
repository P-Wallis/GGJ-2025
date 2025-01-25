extends Control
class_name Ingredient

@export var value:int
@export var operation:DragData.Operation

func _get_drag_data(at_position:Vector2)->Variant:
	set_drag_preview(get_node("Graphic").duplicate())
	return DragData.new(DragData.DragType.INGREDIENT, value, operation)
