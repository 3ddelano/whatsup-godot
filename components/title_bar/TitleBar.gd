class_name TitleBar
extends PanelContainer

@onready var _minimize_btn = %MinimizeBtn
@onready var _middle_btn = %MiddleBtn
@onready var _close_btn = %CloseBtn

var maximized = false

var _last_windowed_position: Vector2i
var _last_windowed_size: Vector2i


func _ready() -> void:
	_update_last_values()
	_minimize_btn.get_node("Button").pressed.connect(_on_minimize_btn_pressed)
	_middle_btn.get_node("Button").pressed.connect(_on_middle_btn_pressed)
	_close_btn.get_node("Button").pressed.connect(_on_close_btn_pressed)


func _on_minimize_btn_pressed():
	minimize()


func _on_middle_btn_pressed():
	if is_maximized():
		windowed()
	else:
		maximize()


func _on_close_btn_pressed():
	get_tree().quit()


func _update_last_values():
	_last_windowed_position = DisplayServer.window_get_position()
	_last_windowed_size =DisplayServer.window_get_size()


func is_maximized() -> bool:
	return DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_WINDOWED


func minimize() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)


func windowed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_position(_last_windowed_position)
	DisplayServer.window_set_size(_last_windowed_size)


func maximize() -> void:
	_update_last_values()
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
