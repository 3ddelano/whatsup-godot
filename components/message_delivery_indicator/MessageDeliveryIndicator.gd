class_name MessageDeliveryIndicator
extends TextureRect

var DELIVERED_COLOR = Color("#9E9E9E")
var SEEN_COLOR = Color("#3273C9")


var data: MessageData:
	set(p_data):
		data = p_data
		if not data.changed.is_connected(_build_ui): data.changed.connect(_build_ui)
		_build_ui()


func _build_ui():
	if data.seen:
		self_modulate = SEEN_COLOR
	else:
		self_modulate = DELIVERED_COLOR
