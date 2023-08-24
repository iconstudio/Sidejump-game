/// @description setting_read_part(map)
/// @function setting_read_part
/// @param map { ds_map }
function setting_read_part(argument0) {
	ds_map_add(global.settings, "version", GM_version)

	var value = ds_map_find_value(argument0, "volume_music")
	if !is_undefined(value)
		ds_map_add(global.settings, "volume_music", value)
	else
		ds_map_add(global.settings, "volume_music", 10)

	var value = ds_map_find_value(argument0, "volume_sfx")
	if !is_undefined(value)
		ds_map_add(global.settings, "volume_sfx", value)
	else
		ds_map_add(global.settings, "volume_sfx", 10)

	var value = ds_map_find_value(argument0, "fullscreen")
	if !is_undefined(value)
		ds_map_add(global.settings, "fullscreen", value)
	else
		ds_map_add(global.settings, "fullscreen", 1) // true

	var value = ds_map_find_value(argument0, "shake")
	if !is_undefined(value)
		ds_map_add(global.settings, "shake", value)
	else
		ds_map_add(global.settings, "shake", 1) // true

	var value = ds_map_find_value(argument0, "graphics")
	if !is_undefined(value)
		ds_map_add(global.settings, "graphics", value)
	else
		ds_map_add(global.settings, "graphics", 2) // high




}
