class_name TimeUtils


static func unix_to_local_time_str(unix: float) -> String:
	@warning_ignore("narrowing_conversion")
	var dict = Time.get_time_dict_from_unix_time(unix)
	var tz_bias = Time.get_time_zone_from_system().bias

	var seconds = (dict.hour * 3600) + (dict.minute * 60) + dict.second + (tz_bias * 60)
	dict.hour = floor(seconds / 3600)
	seconds -= dict.hour * 3600
	dict.minute = floor(seconds / 60)
	seconds -= dict.minute * 60

	var meridiem = "AM"
	if dict.hour >= 12: meridiem = "PM"

	var hour = dict.hour
	if hour >= 13: hour -= 12

	return "%s:%s %s" % [hour, dict.minute, meridiem]
