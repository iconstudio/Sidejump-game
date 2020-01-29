/// @description setting_load()
/// @function setting_load
if file_exists(global.file_settings) {
	var destination = file_text_open_write(global.file_settings)
	var result = json_encode(global.settings)
	file_text_write_string(destination, result)
	file_text_writeln(destination)
	file_text_close(destination)
} else {
	setting_clear()
	setting_save()
}

global.setting_music = 10
global.setting_sfx = 10
global.setting_fullscreen = true
global.setting_graphics = 2
global.setting_on_shake = true
