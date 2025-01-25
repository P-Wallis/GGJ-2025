extends Panel

var currentValue:int = 1
@onready var label:Label = get_node("Label");

func _can_drop_data(at_position:Vector2, data:Variant)->bool:
	if !data["item"] == "Cauldron":
		return false
	
	return true

func _drop_data(at_position:Vector2, data:Variant)->void:
	currentValue = currentValue ^ data["value"]
	label.text = str(currentValue);
