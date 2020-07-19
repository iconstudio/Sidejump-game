/// @description setting_set_value(name, value)
/// @function setting_set_value
/// @param name { string }
/// @param value { any }
function setting_set_value(argument0, argument1) {
	ds_map_replace(global.settings, argument0, argument1)



}
