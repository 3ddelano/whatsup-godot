class_name Chats
extends HBoxContainer

# Required for tweening
@onready var list = %ChatsList


@onready var chat_messages = %ChatMessages
@onready var landing = %ChatsLanding


func _ready() -> void:
	Store.chats_list_item_selected.connect(_on_chats_list_item_selected)


func _on_chats_list_item_selected(_chats_list_item: ChatsListItem):
	landing.visible = false
	chat_messages.visible = true
