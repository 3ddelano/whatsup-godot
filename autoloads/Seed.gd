extends Node

const MIN_TO_S = 60
const HR_TO_S = 3600

var my_avatar = preload("res://assets/avatars/my_avatar.jpeg")
var avatars = {
	female1 = preload("res://assets/avatars/female1.jpeg"),
	female2 = preload("res://assets/avatars/female2.jpeg"),
	female3 = preload("res://assets/avatars/female3.jpeg"),
	male1 = preload("res://assets/avatars/male1.jpeg"),
	male2 = preload("res://assets/avatars/male2.jpeg"),
	male3 = preload("res://assets/avatars/male3.jpeg"),
	male4 = preload("res://assets/avatars/male4.jpeg")
}

var contacts = [
	ContactData.new("Emily Callahan", "+1 2067806682", avatars.female1),
	ContactData.new("Nina Vargas", "+1 6075632651", null, "This is me."),
	ContactData.new("Sheri Thomas", "+91 6611292220", avatars.female2, "Ideas are useless if they remain unused."),
	ContactData.new("Kristy Stevens", "+91 7317256109", avatars.female3, "I am private. Ask me no questions, and you shall hear no lies."),

	ContactData.new("Russell Stewart", "+91 8079911442"),
	ContactData.new("Bae 💘", "+91 9876543210", avatars.male1, "Stay mysterious - it’s better."),
	ContactData.new("John Fernandes", "+91 8073341937", avatars.male2),
	ContactData.new("Patil Naik", "+1 9478386229", avatars.male3, "No one was born tough – life makes them so."),
	ContactData.new("Jacob Gomes", "+91 8628739861", avatars.male4, "My excuse – I’m young."),
]


# Odd msgs are always sent by the sender, even msgs are received
var conversations = [
	[
		"",
		"Hey I just made a clone of WhatsApp using the Godot Game Engine. Do you want to try it out?",
		"Absolutely!",
		"How was it?",
		"I really loved the animations and subtle attention to detail. Great work!",
	],
	[
		"I love cakes, especially chocolate ones. The rich, velvety texture and the sweet taste are simply irresistible.",
		"Oh, I agree! Chocolate cakes are a classic favorite. But have you ever tried a decadent red velvet cake? The combination of the vibrant color and the subtle hint of cocoa is just delightful.",
		"Red velvet cakes are indeed a treat for the eyes and taste buds. But let's not forget about fruit cakes. They're packed with juicy fruits and nuts, making them a delightful option for those who prefer a lighter, refreshing flavor.",
		"Fruit cakes are great, especially during the holiday season. Speaking of which, have you ever had a traditional Christmas fruitcake? The aroma of spices and the soaked fruits make it so nostalgic and cozy.",
		"Absolutely! Christmas fruitcakes bring back fond memories. But if we're talking about nostalgia, I can't help but mention pound cakes. They have a simple, buttery flavor that takes me back to my childhood.",
		"Pound cakes are timeless classics. And you know what else is incredible? Cheesecakes! They come in so many flavors and variations. From New York-style to fruity ones, they always satisfy my dessert cravings.",
	],
	[
		"I've been regularly exercising for a month and I can see the results. Exercise not only strengthens our bodies but also improves our overall well-being.",
		"I couldn't agree more. Engaging in regular exercise helps to boost our energy levels and enhance our endurance. It's amazing how a little physical activity can make us feel more alive and energetic.",
		"Definitely! And let's not forget about the benefits of exercise for our mental health. It has been proven to reduce stress, anxiety, and depression, promoting a positive mindset and improving our overall mood.",
		"That's so true. Whenever I engage in physical activity, whether it's a brisk walk or a challenging workout, I always feel a sense of release and mental clarity. It's like a natural stress-reliever and mood booster.",
		"Absolutely! Exercise has a profound impact on our cardiovascular health as well. Whether it's cardio exercises like running or cycling or engaging in sports, it strengthens our heart, improves blood circulation, and reduces the risk of heart diseases.",
		"Cardiovascular health is crucial, and exercise plays a significant role in maintaining it. But let's not overlook the importance of strength training. Building and toning our muscles not only enhances our physical appearance but also improves our posture and overall strength.",
	],
	[
		"Gardening is such a fulfilling and therapeutic activity. There's something truly magical about nurturing plants and witnessing them grow and flourish.",
		"I couldn't agree more. Gardening allows us to connect with nature and create our own little green oasis. The fresh air, the scent of flowers, and the satisfaction of seeing the fruits of our labor—it's incredibly rewarding.",
		"Absolutely! And the best part is that gardening is for everyone, regardless of the available space. Whether you have a sprawling backyard or just a small balcony, you can still enjoy the wonders of gardening and bring life to your surroundings.",
		"That's the beauty of gardening. It's so versatile and adaptable. Even if you don't have a lot of space, container gardening or vertical gardening can still enable you to grow a variety of plants and create a vibrant atmosphere.",
		"Container gardening is fantastic, especially for those living in apartments or urban areas. You can grow herbs, flowers, or even small vegetables in pots, and they add a touch of greenery to any space.",
		"Absolutely! And let's not forget about the therapeutic benefits of gardening. It's a wonderful stress-reliever, allowing us to disconnect from the digital world and find solace in the simplicity of tending to plants.",
		"Gardening is like a form of meditation. It helps us slow down, be present in the moment, and appreciate the beauty of nature. The act of digging in the soil, planting seeds, and caring for plants can be incredibly grounding and calming.",
		"I completely agree. And beyond the mental and emotional benefits, gardening also promotes physical well-being. It's a great way to get some exercise, whether it's digging, weeding, or simply being active outdoors.",
		"Gardening indeed keeps us active and engaged with the natural world. It's also a fantastic opportunity to learn and expand our knowledge about different plants, their specific needs, and the art of nurturing them.",
		"Absolutely! Gardening is a continuous learning process. It allows us to develop new skills, experiment with different techniques, and gain a deeper understanding of the natural cycles and rhythms of plants.",
		"And let's not forget the joy of harvesting our own homegrown fruits, vegetables, and herbs. There's something incredibly satisfying about bringing fresh produce from the garden to our table. It's not only nutritious but also a testament to our efforts and care.",
		"That's one of the most delightful aspects of gardening. The taste and quality of homegrown produce are unparalleled. It's a rewarding experience to savor the flavors of our hard work and enjoy the fruits of nature.",
		"Absolutely! And gardening also allows us to contribute positively to the environment. By growing our own plants and flowers, we help promote biodiversity, support pollinators, and create habitats for birds and beneficial insects.",
		"Gardening plays a crucial role in conservation efforts. Whether it's planting native species, creating bee-friendly gardens, or practicing sustainable gardening methods, we can make a difference in preserving and protecting our natural ecosystems.",
		"That's so true. Gardening gives us a sense of responsibility and a connection to the Earth. It reminds us of our role as caretakers and stewards of the environment, and it encourages us to make conscious choices that promote a greener and healthier planet.",
	],
	[
		"Hey you there?"
	],
	[
		"I just played Genesis Impact on PC. PC games are so fun. The immersive worlds and thrilling gameplay never fail to captivate me.",
		"I couldn't agree more! The graphics and realism in modern PC games are mind-blowing. It's like stepping into another dimension and experiencing adventures like never before.",
		"Absolutely! And let's not forget about the vast range of game genres available. Whether you're into action-packed shooters, immersive role-playing games, or challenging strategy games, there's something for everyone on the PC.",
		"That's the beauty of PC gaming. The variety is endless, and you can always find a game that suits your preferences. Personally, I enjoy exploring open-world games where I can freely roam and discover hidden treasures.",
		"Open-world games are fantastic! The sense of freedom and discovery they provide is unparalleled. But sometimes, I also like to delve into the intense competition of multiplayer games. The adrenaline rush of battling against real players is exhilarating.",
		"Oh, I know what you mean! Multiplayer games bring out the competitive spirit and allow you to test your skills against others worldwide. It's an entirely different experience when you're matched up against real human opponents.",
		"Definitely! And let's not forget about the joy of cooperative gameplay. Collaborating with friends or online teammates to achieve a common goal adds a whole new layer of enjoyment to PC gaming.",
	],
	[
		"",
		"Hi! I'm Jane. We met at the GDC conference."
	],
	[
		"Hey did you hear about Artificial intelligence / AI? It is a groundbreaking field that has the potential to revolutionize the way we live and interact with technology.",
		"I've heard a little about it. It's about creating smart systems that can learn and adapt right?",
		"Yup! AI has already made significant advancements in various areas, such as natural language processing, computer vision, and machine learning. These technologies enable computers to understand, interpret, and respond to human language and visual inputs.",
		"It's fascinating how AI algorithms can analyze vast amounts of data and identify patterns and insights that humans may not easily detect. This ability has far-reaching applications in fields like healthcare, finance, and scientific research.",
		"That's true. AI has the potential to enhance decision-making processes and provide valuable insights in fields where data analysis is critical. It can help healthcare professionals in diagnosis and treatment planning or assist financial institutions in detecting fraudulent activities",
	],
	[
		"",
		"Hey, have you been keeping up with the Football World Cup?",
		"Absolutely! It's been an exhilarating tournament so far. The level of competition and the performances by teams have been outstanding.",
		"I couldn't agree more. There have been some surprising upsets and breathtaking goals. It's always thrilling to see underdog teams make their mark on the world stage.",
		"Definitely! The World Cup brings together the best talents from around the world, showcasing their skills and representing their countries with pride. It's a true celebration of the sport.",
		"And the matches have been so intense. The passion and determination displayed by the players are awe-inspiring. You can see how much it means to them to compete at this level.",
		"Absolutely! It's not just about individual talents but also about teamwork and strategy. The way teams coordinate their plays and adapt their tactics throughout the tournament is fascinating to watch.",
		"I've been particularly impressed by some of the standout players. Their speed, agility, and precision are on another level. They make the game so thrilling and unpredictable.",
		"I agree. It's a joy to witness those moments of brilliance on the field. Whether it's a spectacular goal, a skillful dribble, or a jaw-dropping save by the goalkeepers, it keeps us on the edge of our seats.",
		"And let's not forget about the incredible support from the fans. The vibrant colors, the passionate chants, and the electric atmosphere in the stadiums add to the overall excitement of the World Cup.",
		"Absolutely! The fans play a significant role in creating an unforgettable experience. Their unwavering support and enthusiasm make every match feel like a grand spectacle.",
		"So, which team are you rooting for to win the World Cup?",
		"Ah, that's a tough question. There are so many strong teams this year. But I have a soft spot for the underdogs. I'm rooting for the team that surprises everyone and lifts the trophy against all odds.",
		"That's always an exciting outcome. It's those unexpected victories that make the World Cup so memorable. I'll be cheering for a fair and thrilling tournament, where the best team emerges victorious.",
		"Absolutely! May the best team win, and may the World Cup continue to inspire and unite football fans around the globe.",
		"Cheers to that! Let's enjoy the remaining matches and savor every moment of this exhilarating football extravaganza.",
		"Cheers! It's a celebration of the beautiful game, and we're fortunate to witness it. Here's to the Football World Cup and the memories it creates!",
	]
]

func seed_app_data() -> AppData:
	var app_data = AppData.new()

	app_data.my_contact = seed_my_contact()
	app_data.contacts = seed_contacts()
	app_data.chats_data = seed_chats_data()

	return app_data


func seed_my_contact() -> ContactData:
	var contact_data = ContactData.new("Jane Smith", "+91 98123456789", my_avatar, "Just a chill gal!")
	return contact_data


func seed_contacts() -> Dictionary:
	var contacts_dict = {}
	for i in range(len(contacts)):
		var contact: ContactData = contacts[i]
		@warning_ignore("narrowing_conversion")
		contact.status_updated_at = Time.get_unix_time_from_system() - (randi() % (8 * HR_TO_S))
		@warning_ignore("narrowing_conversion")
		contact.last_call_at = Time.get_unix_time_from_system() - (randi() % (8 * HR_TO_S))
		var call_statuses = ContactData.CallStatus.values()
		contact.last_call_status = call_statuses[randi() % len(call_statuses)]
		contacts_dict[contact.phone] = contact

	return contacts_dict


func seed_chats_data() -> ChatsData:
	var chats_data = ChatsData.new()

	var chat_message_datas = []
	for i in range(len(contacts)):
		var contact: ContactData = contacts[i]

		var chat_message_data = ChatMessageData.new()
		chat_message_data.contact = contact
		chat_message_data.messages = seed_chat_messages(conversations[i])

		chat_message_datas.append(chat_message_data)

	chat_message_datas.shuffle()
	for chat_message_data in chat_message_datas:
		chats_data.chats[chat_message_data.contact.phone] = chat_message_data


	return chats_data


func seed_chat_messages(conversation: Array) -> Array[MessageData]:
	var messages: Array[MessageData] = []

	var last_msg_delivered_at = Time.get_unix_time_from_system() - (randi() % (5 * HR_TO_S))
	for i in range(len(conversation)):
		var msg = conversation[i]
		if msg == "": continue

		var msg_data = MessageData.new(msg)
		msg_data.sent_by_me = i % 2 == 1
		msg_data.delivered_at = last_msg_delivered_at
		msg_data.seen = true
		last_msg_delivered_at -= 1 + (randi() % (2 * MIN_TO_S))
		messages.append(msg_data)

	return messages
