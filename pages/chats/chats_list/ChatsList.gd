class_name ChatsList
extends ScrollContainer

@onready var _chats_list_items = %ChatsListItems
@onready var ChatListItemScene = preload("res://pages/chats/chats_list/chats_list_item/ChatsListItem.tscn")


var data: ChatsData


func _ready() -> void:
	data = Store.app_data.chats_data

	data.changed.connect(_build_ui)
	_build_ui()


func _build_ui():
	print("updating chats list ui")

	for child in _chats_list_items.get_children():
		child.queue_free()

	for _chat_message_data in data.chats.values():
		var chat_message_data: ChatMessageData = _chat_message_data
		var contact = chat_message_data.contact

		var chats_list_item = ChatListItemScene.instantiate()
		_chats_list_items.add_child(chats_list_item)
		chats_list_item.data = contact
		chats_list_item.button_group = preload("res://pages/chats/chats_list/chats_list_item/chats_list_item_btn_group.tres")
		chats_list_item.pressed.connect(func ():
			Store.chats_list_item_selected.emit(chats_list_item)
		)
