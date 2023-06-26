class_name ChatsListItem
extends Button


@onready var _avatar = %Avatar
@onready var _name = %Name
@onready var _time = %Time
@onready var _contents = %Contents


var data: ContactData:
	set(p_data):
		data = p_data
		_build_ui()


func _build_ui():
	_avatar.texture = data.avatar
	_name.text = data.name

	_time.text = ""
	_contents.text = ""
	var last_msg: MessageData = data.get_last_msg()
	if last_msg:
		_time.text = TimeUtils.unix_to_time_str(last_msg.delivered_at)
		_contents.text = last_msg.content
	_time.text = TimeUtils.unix_to_time_str(Time.get_unix_time_from_system())
