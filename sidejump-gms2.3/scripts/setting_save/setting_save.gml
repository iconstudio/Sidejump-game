/// @description setting_save()
/// @function setting_save
function setting_save() {
	var destination = file_text_open_write(global.file_settings)
	var result = json_encode(global.settings)
	file_text_write_string(destination, result)
	file_text_close(destination)




}
