/// @description predicate_graphics()
/// @function predicate_graphics
function predicate_graphics() {
	if 0 == open_time {
		var result = ": "
		var value = setting_get_value("graphics")
		if value == 2
			result += "High"
		else if value == 1
			result += "Medium"
		else
			result += "Low"

		return result
	} else {
		return ""
	}



}
