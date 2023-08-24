/// @description setting_clear()
/// @function setting_clear
function setting_clear() {
	ds_map_clear(global.settings)
	ds_map_add(global.settings, "version", GM_version)
	ds_map_add(global.settings, "volume_music", 10)
	ds_map_add(global.settings, "volume_sfx", 10)
	ds_map_add(global.settings, "fullscreen", 1)
	ds_map_add(global.settings, "screen_scale", 1)
	ds_map_add(global.settings, "shake", 1)
	ds_map_add(global.settings, "graphics", 2)



}
