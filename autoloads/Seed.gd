extends Node

var avatars = {
	female1 = preload("res://assets/avatars/female1.jpeg"),
	female2 = preload("res://assets/avatars/female2.jpeg"),
	female3 = preload("res://assets/avatars/female3.jpeg"),
	male1 = preload("res://assets/avatars/male1.jpeg"),
	male2 = preload("res://assets/avatars/male2.jpeg"),
	male3 = preload("res://assets/avatars/male3.jpeg"),
	male4 = preload("res://assets/avatars/male4.jpeg")
}

var contact_abouts = [
	"This is me.",
	"Ideas are useless if they remain unused.",
	"Don’t be too open-minded; your brain might fall out.",
	"Live today – tomorrow is not guaranteed.",
	"My excuse – I’m young.",
	"Stay mysterious - it’s better.",
	"No one was born tough – life makes them so.",
	"I am private. Ask me no questions, and you shall hear no lies.",
	"Let your smile alter the world. Don’t let the opposite happen."
]

func seed_app_data() -> AppData:
	var app_data = AppData.new()

	app_data.contacts = seed_contacts()
	app_data.chats_data = seed_chats_data(app_data.contacts)

	return app_data


func seed_contacts():
	var contacts_arr = [
		ContactData.new("Emily Callahan", "+1 2067806682", avatars.female1),
		ContactData.new("Nina Vargas", "+1 6075632651"),
		ContactData.new("Sheri Thomas", "+91 6611292220", avatars.female2),
		ContactData.new("Kristy Stevens", "+91 7317256109", avatars.female3),

		ContactData.new("Russell Stewart", "+91 8079911442"),
		ContactData.new("Hubby 💘", "+91 9876543210", avatars.male1),
		ContactData.new("John Fernandes", "+91 8073341937", avatars.male2),
		ContactData.new("Patil Naik", "+1 9478386229", avatars.male3),
		ContactData.new("Jacob Gomes", "+91 8628739861", avatars.male4),
	]
	contacts_arr.shuffle()
	contact_abouts.shuffle()

	var contacts = {}
	for i in range(len(contacts_arr)):
		var contact: ContactData = contacts_arr[i]
		contact.about = contact_abouts[i]
		contacts[contact.phone] = contact


	return contacts


func seed_chats_data(contacts: Dictionary) -> ChatsData:
	var chats_data = ChatsData.new()

	for contact in contacts.values():
		var chat_message = ChatMessageData.new()
		chat_message.contact = contact
		chats_data.chats[contact.phone] = chat_message

	return chats_data
