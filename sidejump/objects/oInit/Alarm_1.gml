var window_width = window_get_width()
var window_height = window_get_height()
var gui_width = display_get_gui_width()
var gui_height = display_get_gui_height()

//surface_resize(application_surface, window_width, window_width * 0.5)
global.application_texture = surface_get_texture(application_surface)
global.application_offset = application_get_position()
global.application_sizes = [window_width, window_height]
global.resolutions = [window_width, window_height]
global.resolutions_gui = [gui_width, gui_height]

room_goto_next()
