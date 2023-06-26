class_name SearchBar
extends LineEdit

@onready var _active = $Active
@onready var _inactive = $InActive
@onready var _active_stylebox = preload("res://pages/chats/search_bar_active.tres")
@onready var _inactive_stylebox = preload("res://pages/chats/search_bar_inactive.tres")


func _ready() -> void:
	focus_entered.connect(func():
		_active.visible = true
		_inactive.visible = false
		add_theme_stylebox_override("normal", _active_stylebox)
	)

	focus_exited.connect(func():
		_active.visible = false
		_inactive.visible = true
		add_theme_stylebox_override("normal", _inactive_stylebox)
	)
