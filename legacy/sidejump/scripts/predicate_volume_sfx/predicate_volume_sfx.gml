/// @description predicate_volume_sfx()
/// @function predicate_volume_sfx
if 0 == open_time {
	var result = ": "
	var value = setting_get_value("volume_sfx")
	if value == 0
		result += "Off"
	else
		result += string(value)

	return result
} else {
	return ""
}
