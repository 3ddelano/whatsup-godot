class_name SideMenu
extends PanelContainer


var anim_length_in_sec = 0.25
var delay_multiplier = 0.7

@onready var _chat_btn = %ChatsButton
@onready var _calls_btn = %CallsButton
@onready var _status_btn = %StatusButton
@onready var _selected_indicator = %SelectedButtonIndicator as SelectedButtonIndicator
@onready var _my_avatar = %MyAvatar

var current_btn_selected: Button
var indicator_animate_tween: Tween

var my_contact: ContactData:
	set(p_my_contact):
		my_contact = p_my_contact
		if not my_contact.changed.is_connected(_build_ui): my_contact.changed.connect(_build_ui)
		_build_ui()

func _ready() -> void:
	_chat_btn.pressed.connect(Callable(self, "_on_btn_pressed").bind(_chat_btn, "chat"))
	_calls_btn.pressed.connect(Callable(self, "_on_btn_pressed").bind(_calls_btn, "calls"))
	_status_btn.pressed.connect(Callable(self, "_on_btn_pressed").bind(_status_btn, "status"))

	my_contact = Store.app_data.my_contact

	set_initial_selected_button.call_deferred(_chat_btn)


func _on_btn_pressed(btn: Button, menu_name: String) -> void:
	if current_btn_selected == btn:
		return

	tween_selected_indicator(btn)
	current_btn_selected = btn
	Store.side_menu_btn_pressed.emit(menu_name)


func _build_ui():
	_my_avatar.texture = my_contact.avatar


func set_initial_selected_button(btn: Button) -> void:
	current_btn_selected = btn
	current_btn_selected.button_pressed = true

	var center = get_btn_middle_left_global_position(current_btn_selected)
	_selected_indicator.set_global_position_centered(center)


func get_btn_middle_left_global_position(btn: Button) -> Vector2:
	return btn.global_position + Vector2(0, btn.size.y * 0.5)


func tween_selected_indicator(to_btn: Button) -> void:
	var target_pos = get_btn_middle_left_global_position(to_btn)
	_selected_indicator.tween_slide(target_pos)
