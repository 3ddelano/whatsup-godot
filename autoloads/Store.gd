extends Node


signal side_menu_btn_pressed(menu_name: String)
signal chats_list_item_selected(chats_list_item: ChatsListItem)


var app_data: AppData
var current_chat_message_data: ChatMessageData

func _ready() -> void:
	app_data = Seed.seed_app_data()
