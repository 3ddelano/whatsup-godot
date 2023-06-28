class_name PageManager
extends PanelContainer

@onready var _chats = %Chats
@onready var _calls = %Calls
@onready var _status = %Status


func _ready() -> void:
	Store.side_menu_btn_pressed.connect(_on_side_menu_btn_pressed)


func _on_side_menu_btn_pressed(menu_name: String):
	for child in get_children():
		child.visible = false

	var menu = _chats
	if menu_name == "calls":
		menu = _calls
	elif menu_name == "status":
		menu = _status

	menu.visible = true
	await get_tree().process_frame
	Tweens.slide_up(menu.list)
