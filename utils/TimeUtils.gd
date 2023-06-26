class_name TimeUtils


static func unix_to_time_str(unix: int) -> String:
	var dict = Time.get_time_dict_from_unix_time(unix)

	var meridiem = "AM"
	if dict.hour > 12: meridiem = "PM"

	return "%s:%s %s" % [dict.hour / 12, dict.minute, meridiem]
