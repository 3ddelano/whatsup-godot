class_name ContactData
extends Resource


var name: String
var phone: String
var avatar: Texture2D
var about: String
var last_seen_at: int


func _init(p_name: String, p_phone: String, p_avatar = null):
	name = p_name
	phone = p_phone

	var default_avatar = preload("res://assets/avatars/default_avatar.svg")
	if p_avatar:
		avatar = p_avatar
	else:
		avatar = default_avatar


func get_last_msg() -> MessageData:
	var chats_data: ChatsData = Store.app_data.chats_data
	if not phone in chats_data:
		return null

	var chat_message_data: ChatMessageData = chats_data[phone]
	var msgs: Array[MessageData] = chat_message_data.messages.values()
	if msgs.size() == 0:
		return null

	return msgs[0]
