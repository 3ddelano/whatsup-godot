class_name CallsListItem
extends Button

const NOT_MISSED_COLOR = Color("#41C977")
const MISSED_COLOR = Color("#E4626E")

@onready var _avatar = %Avatar
@onready var _name = %Name
@onready var _contents = %Contents
@onready var _received = %Received
@onready var _sent = %Sent


var data: ContactData:
	set(p_data):
		data = p_data
		if not data.changed.is_connected(_build_ui): data.changed.connect(_build_ui)
		_build_ui()


func _build_ui():
	_avatar.texture = data.avatar
	_name.text = data.name

	_contents.text = TimeUtils.unix_to_local_time_str(data.last_call_at)

	_sent.get_parent().modulate = NOT_MISSED_COLOR
	_sent.visible = false
	_received.visible = false
	_name.modulate = Color("#fff")
	if data.last_call_status == ContactData.CallStatus.Sent:
		_sent.visible = true
	else:
		_received.visible = true

	if data.last_call_status == ContactData.CallStatus.MissedReceived:
		_name.modulate = MISSED_COLOR
		_sent.get_parent().modulate = MISSED_COLOR
