class_name ContactData
extends Resource


var name: String:
	set(p_name):
		name = p_name
		emit_changed()

var phone: String:
	set(p_phone):
		phone = p_phone
		emit_changed()

var avatar: Texture2D:
	set(p_avatar):
		avatar = p_avatar
		emit_changed()

var about: String = "Hey there! I'm using WhatsGodot.":
	set(p_about):
		about = p_about
		emit_changed()

var last_seen_at: int:
	set(p_last_seen_at):
		last_seen_at = p_last_seen_at
		emit_changed()


func _init(p_name: String, p_phone: String, p_avatar = null, p_about = ""):
	name = p_name
	phone = p_phone
	about = p_about


	var default_avatar = preload("res://assets/avatars/default_avatar.svg")
	if p_avatar:
		avatar = p_avatar
	else:
		avatar = default_avatar


func get_last_msg() -> MessageData:
	var chats_data: Dictionary = Store.app_data.chats_data.chats
	if not phone in chats_data:
		return null

	var chat_message_data: ChatMessageData = chats_data[phone]
	var msgs: Array[MessageData] = chat_message_data.messages
	if msgs.size() == 0:
		return null

	return msgs[-1]
