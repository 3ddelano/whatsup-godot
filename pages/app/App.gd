class_name App
extends Control


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
