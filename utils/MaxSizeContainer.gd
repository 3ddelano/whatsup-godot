class_name MaxSizeContainer
extends Container

enum VerticalAlign {TOP, CENTER, BOTTOM}
enum HorizontalAlign {LEFT, CENTER, RIGHT}

## The maximum size of the container's bounding rectangle.
## Set to -1 to take all the space in that direction.
@export
var max_size := Vector2(-1, -1):
	set(p_max_size):
		max_size = p_max_size
		_fit_child()

@export
var vertical_align: VerticalAlign = VerticalAlign.CENTER:
	set(p_vertical_align):
		vertical_align = p_vertical_align
		_fit_child()

@export
var horizontal_align: HorizontalAlign = HorizontalAlign.CENTER:
	set(p_horizontal_align):
		horizontal_align = p_horizontal_align
		_fit_child()


func _enter_tree() -> void:
	update_configuration_warnings()


func _get_configuration_warnings():
	if get_child_count() != 1:
		return ["MaxSizeContainer expects a single child node"]
	return []


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		_fit_child()


func _fit_child():
	if get_child_count() != 1: return

	var custom_position = Vector2.ZERO

	if max_size.x != -1:
		match horizontal_align:
			HorizontalAlign.CENTER:
				custom_position.x = max(0, (size.x - max_size.x) / 2)
			HorizontalAlign.RIGHT:
				custom_position.x = max(0, size.x - max_size.x)

	if max_size.y != -1:
		match vertical_align:
			VerticalAlign.CENTER:
				custom_position.y = max(0, (size.y - max_size.y) / 2)
			VerticalAlign.BOTTOM:
				custom_position.y = max(0, size.y - max_size.y)

	var custom_size = size
	if max_size.x != -1:
		custom_size.x = min(size.x, max_size.x)
	if max_size.y != -1:
		custom_size.y = min(size.y, max_size.y)

	fit_child_in_rect(get_child(0), Rect2(custom_position, custom_size))


func _get_minimum_size() -> Vector2:
	if get_child_count() == 0:
		return custom_minimum_size

	var child_min_size = get_child(0).get_combined_minimum_size()
	return Vector2(
		max(custom_minimum_size.x, child_min_size.x),
		max(custom_minimum_size.y, child_min_size.y)
	)
