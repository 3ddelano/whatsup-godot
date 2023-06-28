class_name StatusListItem
extends Button


@onready var _avatar = %Avatar
@onready var _name = %Name
@onready var _contents = %Contents


var data: ContactData:
	set(p_data):
		data = p_data
		if not data.changed.is_connected(_build_ui): data.changed.connect(_build_ui)
		_build_ui()


func _build_ui():
	_avatar.texture = data.avatar
	_name.text = data.name

	if data.status_updated_at == 0:
		_contents.text = "No updates"
	else:
		_contents.text = TimeUtils.unix_to_local_time_str(data.status_updated_at)
