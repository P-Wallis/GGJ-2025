extends Panel
class_name Cauldron

@export var mugDragObject:PackedScene
var label:Label
var currentValue:int = 5

func _ready():
	label = get_node("Label");
	updateLabel(currentValue)

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
	updateLabel(currentValue)
	
func updateLabel(value:int):
	var outString:String = ""
	var power:int = 1
	for p in 9:
		if(value & power) > 0:
			outString += "1"
		else:
			outString += "0"
		power *= 2
	label.text = outString;
