class_name ChatMessageData
extends Resource

signal message_added(msg_data: MessageData)

var contact: ContactData

var messages: Array[MessageData]


func add_message(msg_data: MessageData):
	messages.append(msg_data)
	message_added.emit(msg_data)
