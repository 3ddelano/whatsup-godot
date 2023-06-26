class_name PageManager
extends PanelContainer

@onready var _chats = %Chats
@onready var _calls = %Calls


func _ready() -> void:
	Store.side_menu_btn_pressed.connect(_on_side_menu_btn_pressed)


func _on_side_menu_btn_pressed(menu_name: String):
	for child in get_children():
		child.visible = false

	var menu = _chats
	if menu_name == "calls":
		menu = _calls

	menu.visible = true
	Tweens.slide_up(menu.list)
