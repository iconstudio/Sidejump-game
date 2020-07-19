/// @description setting_get_value(name)
/// @function setting_get_value
/// @param name { string }
function setting_get_value(argument0) {
	return ds_map_find_value(global.settings, argument0)



}
