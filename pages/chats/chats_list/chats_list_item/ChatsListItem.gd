class_name ChatsListItem
extends Button


@onready var _avatar = %Avatar
@onready var _name = %Name
@onready var _time = %Time
@onready var _contents = %Contents
@onready var _msg_delivery_indicator = %MessageDeliveryIndicator


var data: ContactData:
	set(p_data):
		data = p_data
		_build_ui()


func _build_ui():
	_avatar.texture = data.avatar
	_name.text = data.name

	_time.text = ""
	_contents.text = ""
	_msg_delivery_indicator.visible = false

	var last_msg: MessageData = data.get_last_msg()
	if last_msg:
		_time.text = TimeUtils.unix_to_local_time_str(last_msg.delivered_at)
		_contents.text = last_msg.content

		if last_msg.sent_by_me:
			_msg_delivery_indicator.data = last_msg
			_msg_delivery_indicator.visible = true
