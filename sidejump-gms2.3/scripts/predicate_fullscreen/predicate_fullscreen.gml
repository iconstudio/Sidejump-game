/// @description predicate_fullscreen()
/// @function predicate_fullscreen
function predicate_fullscreen() {
	if 0 == open_time {
		var result = ": "
		var value = setting_get_value("fullscreen")
		if value
			result += "On"
		else
			result += "Off"

		return result
	} else {
		return ""
	}



}
