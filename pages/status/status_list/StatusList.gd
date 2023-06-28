class_name StatusList
extends ScrollContainer


@onready var _status_list_items = %StatusListItems
@onready var StatusListItemScene = preload("res://pages/status/status_list/status_list_item/StatusListItem.tscn")
@onready var _my_status = %MyStatus

var statuses: Array[ContactData]


func _ready() -> void:
	_my_status.data = Store.app_data.my_contact

	for _contact_data in Store.app_data.contacts.values():
		var contact_data: ContactData = _contact_data
		if randi() % 3 in [0,1] or \
		contact_data.status_updated_at == 0: continue
		statuses.append(contact_data)

	_build_ui()


func _build_ui():
	for child in _status_list_items.get_children():
		child.queue_free()

	for contact_data in statuses:
		var status_list_item = StatusListItemScene.instantiate()
		_status_list_items.add_child(status_list_item)
		status_list_item.data = contact_data
		status_list_item.button_group = preload("res://pages/status/status_list/status_list_item/status_list_item_btn_group.tres")
