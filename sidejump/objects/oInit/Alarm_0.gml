display_set_gui_size(default_width, default_height)
window_width = window_get_width()
window_height = window_get_height()

global.application_texture = surface_get_texture(application_surface)
global.application_offset = application_get_position()
global.application_sizes = [window_width, window_width * 0.5]

var gui_x = 0
if window_get_fullscreen() {
	//*
	var display_ratio = display_height / display_width
	var i = max(1, default_width / display_width)
	var s = max(1, default_height / display_height)
	var display_scale_max = min(i, s)
	//*/
	if display_height < display_width * 0.5 {
		global.application_sizes = [display_height * 2, display_height]
		//display_set_gui_size(default_width, default_width / display_ratio)
	} else {
		global.application_sizes = [display_width, display_width * 0.5]
		//display_set_gui_size(default_height / display_ratio, default_height)
	}
}

gui_width = display_get_gui_width()
gui_height = display_get_gui_height()
global.resolutions_gui = [gui_width, gui_height]

instance_create_layer(0, 0, layer, oGlobal)
instance_create_layer(0, 0, layer, oGamepad)
instance_create_layer(0, 0, layer, oCursor)

room_goto_next()
