/// @description setting_fullscreen_apply()
/// @function setting_fullscreen_apply
if global.flag_is_desktop {
	window_set_fullscreen(setting_get_value("fullscreen"))
	if window_get_fullscreen() {
		//surface_resize(application_surface, display_get_width(), display_get_height() * 0.5)
	} else {
		//surface_resize(application_surface, window_get_width(), window_get_width() * 0.5)
	}
	display_set_gui_size(global.resolutions_default[0], global.resolutions_default[1])
	global.application_offset = application_get_position()
	global.application_texels = [texture_get_texel_width(global.application_texture), texture_get_texel_height(global.application_texture)]

}
