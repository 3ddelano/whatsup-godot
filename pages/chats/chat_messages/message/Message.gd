@tool
class_name Message
extends MaxSizeContainer


@onready var _content = %Content
@onready var _time = %Time
@onready var _msg_delivery_indicator = %MessageDeliveryIndicator
@onready var _msg_left_triangle = %MessageLeftTriangle
@onready var _msg_right_triangle = %MessageRightTriangle
@onready var _panel_container = $PanelContainer


var MessageReceivedStyleBox = preload("res://pages/chats/chat_messages/message/message_received_stylebox.tres")
var MessageSentStyleBox = preload("res://pages/chats/chat_messages/message/message_sent_stylebox.tres")


var data: MessageData:
	set(p_data):
		data = p_data
		if not data.changed.is_connected(_build_ui): data.changed.connect(_build_ui)
		_build_ui()


func _build_ui():
	_content.text = data.content
	_time.text = TimeUtils.unix_to_local_time_str(data.delivered_at)
	_msg_delivery_indicator.data = data

	_msg_left_triangle.visible = false
	_msg_right_triangle.visible = false
	_msg_delivery_indicator.visible = false
	horizontal_align = HorizontalAlign.LEFT

	if data.sent_by_me:
		_build_sent_by_me_message()
	else:
		_build_receivd_message()

	await get_tree().process_frame

	if _content.size.x > _get_max_horizontal_size():
		_content.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		_panel_container.size_flags_horizontal = SIZE_FILL


func _build_receivd_message():
	_msg_left_triangle.visible = true

	_panel_container.add_theme_stylebox_override("panel", MessageReceivedStyleBox)


func _build_sent_by_me_message():
	_msg_right_triangle.visible = true
	_msg_delivery_indicator.visible = true

	horizontal_align = HorizontalAlign.RIGHT
	_panel_container.size_flags_horizontal = SIZE_SHRINK_END

	_panel_container.add_theme_stylebox_override("panel", MessageSentStyleBox)


func _get_max_horizontal_size():
	return 740


func _update_max_horizontal_size(new_max_horizontal_size: int):
	max_size.x = new_max_horizontal_size
