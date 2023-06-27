class_name InputArea
extends PanelContainer


@onready var _message_input = %MessageInput
@onready var _audio_btn = %AudioBtn
@onready var _send_btn = %SendBtn


func _ready() -> void:
	_message_input.text_changed.connect(_on_message_input_text_changed)
	_message_input.text_submitted.connect(func (_new_text): _send_message())
	_send_btn.pressed.connect(_send_message)


func _sanitize_message_content(content: String):
	return content.strip_edges()


func _on_message_input_text_changed(new_text: String):
	_update_send_button_visibility()


func _update_send_button_visibility():
	if _sanitize_message_content(_message_input.text).length() > 0:
		_send_btn.visible = true
		_audio_btn.visible = false
	else:
		_send_btn.visible = false
		_audio_btn.visible = true


func _send_message():
	var content = _sanitize_message_content(_message_input.text)
	if content.length() == 0: return

	_message_input.text = ""
	var msg_data = MessageData.new(content)
	msg_data.sent_by_me = true
	msg_data.delivered_at = Time.get_unix_time_from_system()
	Store.current_chat_message_data.add_message(msg_data)
	_update_send_button_visibility()
	_mark_message_as_seen_after(msg_data, 5)


func _mark_message_as_seen_after(msg_data: MessageData, time_sec: int):
	await get_tree().create_timer(time_sec).timeout
	msg_data.seen = true
