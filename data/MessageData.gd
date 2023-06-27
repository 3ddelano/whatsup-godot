class_name MessageData
extends Resource


var content: String:
	set(p_content):
		content = p_content
		emit_changed()

var delivered_at: float:
	set(p_delivered_at):
		delivered_at = p_delivered_at
		emit_changed()

var sent_by_me: bool:
	set(p_sent_by_me):
		sent_by_me = p_sent_by_me
		emit_changed()

var seen: bool:
	set(p_seen):
		seen = p_seen
		emit_changed()



func _init(p_content: String):
	content = p_content
