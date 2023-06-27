class_name ChatsMessages
extends VBoxContainer

@onready var _contact_avatar = %ContactAvatar
@onready var _contact_name = %ContactName
@onready var _contact_subtitle = %ContactSubtitle
@onready var _messages_scroll_container = %MessagesScrollContainer
@onready var _messages = %Messages
@onready var _scroll_down_helper = %ScrollDownHelper

@onready var MessageScene = preload("res://pages/chats/chat_messages/message/Message.tscn")


var data: ChatMessageData:
	set(p_data):
		data = p_data
		if not data.changed.is_connected(_build_ui): data.changed.connect(_build_ui)
		if not data.message_added.is_connected(_on_message_added): data.message_added.connect(_on_message_added)
		_build_ui()


func _ready() -> void:
	Store.chats_list_item_selected.connect(_on_chats_list_item_selected)


func _on_chats_list_item_selected(chat_list_item: ChatsListItem):
	var contact: ContactData = chat_list_item.data

	var chat_message_data: ChatMessageData = Store.app_data.chats_data.chats[contact.phone]
	data = chat_message_data
	Store.current_chat_message_data = chat_message_data


func _build_ui():
	_contact_avatar.texture = data.contact.avatar
	_contact_name.text = data.contact.name
	_contact_subtitle.text = "select for contact info"

	for child in _messages.get_children():
		child.queue_free()

	for i in range(len(data.messages)):
		var msg_data: MessageData = data.messages[i]
		_instance_message(msg_data)
	_scroll_to_bottom()


func _on_message_added(msg_data: MessageData):
	_instance_message(msg_data)
	_scroll_to_bottom()


func _instance_message(msg_data: MessageData):
	var message = MessageScene.instantiate()
	_messages.add_child(message)
	message.data = msg_data


func _scroll_to_bottom():
	await get_tree().process_frame
	await get_tree().process_frame
	_messages_scroll_container.ensure_control_visible(_scroll_down_helper)
