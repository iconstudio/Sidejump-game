/// @description setting_load()
/// @function setting_load
if file_exists(global.file_settings) {
	show_debug_message("a setting file found.")
	var source = file_text_open_read(global.file_settings)
	var data = file_text_read_string(source)
	var result = json_decode(data)
	if ds_exists(result, ds_type_map) {
		show_debug_message("a map found in the file.")
		var version = ds_map_find_value(result, "version")
		if !is_undefined(version) {
			if version == GM_version {
				show_debug_message("existed settings has same version of game.")
				ds_map_copy(global.settings, result)
			} else {
				show_debug_message("existed settings has different version of game.")
				setting_read_part(result)
			}
			ds_map_destroy(result)
		} else {
			show_error("올바르지 않은 설정 파일입니다.", true)
		}
	}

	show_debug_message("settings loaded.")
	file_text_close(source)
} else {
	show_debug_message("there is no setting already made.")
	setting_clear()
	setting_save()
}
