class_name Chats
extends HBoxContainer

# Required for tweening
@onready var list = %ChatsList


@onready var chat_messages = %ChatMessages
@onready var landing = %Landing


func _ready() -> void:
	Store.chats_list_item_selected.connect(_on_chats_list_item_selected)


func _on_chats_list_item_selected(chats_list_item: ChatsListItem):
	print(chats_list_item)
