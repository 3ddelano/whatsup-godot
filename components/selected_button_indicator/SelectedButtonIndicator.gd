class_name SelectedButtonIndicator
extends Node2D

@onready var top = $Top
@onready var bottom = $Bottom
@onready var panel = $Panel


var _tween: Tween
var _initial_panel_size: Vector2


func _ready() -> void:
	_initial_panel_size = panel.size


func _process(_delta: float) -> void:
	panel.global_position = top.global_position
	var height = bottom.global_position.y - top.global_position.y
	panel.size.y = height


func set_global_position_centered(target_pos: Vector2, panel_size: Vector2 = panel.size):
	top.global_position.x = target_pos.x
	top.global_position.y = target_pos.y - panel_size.y * 0.5

	bottom.global_position.x = target_pos.x
	bottom.global_position.y = target_pos.y + panel_size.y * 0.5


func tween_slide(target_pos: Vector2, duration_s := 0.2, quickness := 0.5) -> void:
	if _tween:
		_tween.stop()
		_tween = null
		set_global_position_centered(target_pos, _initial_panel_size)
		return

	_tween = create_tween().set_parallel(true)
	_tween.finished.connect(func ():
		_tween = null
	)

	var half_height = panel.size.y * 0.5
	# Calculate the target top and bottom global positions to tween to
	var target_top_y = target_pos.y - half_height
	var target_bottom_y = target_pos.y + half_height


	if top.global_position.y < target_top_y:
		# Move down: Bottom must reach first
		_tween.tween_property(top, "global_position:y", target_top_y, duration_s).set_ease(Tween.EASE_OUT)
		_tween.tween_property(bottom, "global_position:y", target_bottom_y, duration_s * quickness).set_ease(Tween.EASE_IN)
	else:
		# Move up: Top must reach first
		_tween.tween_property(top, "global_position:y", target_top_y, duration_s * quickness).set_ease(Tween.EASE_IN)
		_tween.tween_property(bottom, "global_position:y", target_bottom_y, duration_s).set_ease(Tween.EASE_OUT)
