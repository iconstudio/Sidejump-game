/// @description callback_set_fullscreen(value)
/// @function callback_set_fullscreen
/// @param value { integer }
function callback_set_fullscreen(argument0) {
	setting_set_value("fullscreen", argument0)
	setting_fullscreen_apply()



}
