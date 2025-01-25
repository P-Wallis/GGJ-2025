extends Panel

@export var mugDragObject:PackedScene

func _get_drag_data(at_position:Vector2)->Variant:
	var item = "Cauldron";

	var drag_data:Dictionary = {"item":item, "value":1}
	set_drag_preview(mugDragObject.instantiate())

	return drag_data
