class_name MoveWindow
extends VSeparator


var is_moving = false
var current_window_position: Vector2


func _ready() -> void:
	update_current_window_position()


func _process(_delta: float) -> void:
	read_mouse_input()


func _gui_input(event: InputEvent) -> void:
	if is_moving and event is InputEventMouseMotion:
		move_window(event.relative)


func update_current_window_position():
	current_window_position = DisplayServer.window_get_position()


func read_mouse_input():
	if Input.is_action_just_pressed("left_click"):
		is_moving = true
		update_current_window_position()

	if Input.is_action_just_released("left_click"):
		is_moving = false


func move_window(direction: Vector2):
	DisplayServer.window_set_position(current_window_position + direction)
	current_window_position = DisplayServer.window_get_position()
