/// @description predicate_volume_music()
/// @function predicate_volume_music
if 0 == open_time {
	var result = ": "
	var value = setting_get_value("volume_music")
	if value == 0
		result += "Off"
	else
		result += string(value)

	return result
} else {
	return ""
}
