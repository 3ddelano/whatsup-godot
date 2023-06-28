class_name CallsList
extends ScrollContainer

@onready var _calls_list_items = %CallsListItems
@onready var CallsListItemScene = preload("res://pages/calls/calls_list/calls_list_item/CallsListItem.tscn")

var calls: Array[ContactData]


func _ready() -> void:

	for _contact_data in Store.app_data.contacts.values():
		var contact_data: ContactData = _contact_data
		if randi() % 5 in [0, 1, 2]: continue
		calls.append(contact_data)

	_build_ui()


func _build_ui():
	for child in _calls_list_items.get_children():
		child.queue_free()

	for contact_data in calls:
		var calls_list_item = CallsListItemScene.instantiate()
		_calls_list_items.add_child(calls_list_item)
		calls_list_item.data = contact_data
		calls_list_item.button_group = preload("res://pages/calls/calls_list/calls_list_item/calls_list_item_btn_group.tres")
