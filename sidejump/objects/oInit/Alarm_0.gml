/// @description 설정 적용, 관리 객체 생성 및 룸 넘어가기
display_width = display_get_width()
display_height = display_get_height()
display_set_gui_size(global.resolutions_default[0], global.resolutions_default[1])
window_width = window_get_width()
window_height = window_get_height()

global.application_texture = surface_get_texture(application_surface)
global.application_offset = application_get_position()
global.application_sizes = [window_width, window_width * 0.5]
global.application_texels = [texture_get_texel_width(global.application_texture), texture_get_texel_height(global.application_texture)]
setting_apply()

gui_width = display_get_gui_width()
gui_height = display_get_gui_height()
global.resolutions_gui = [gui_width, gui_height]

instance_create_layer(0, 0, layer, oGlobal)
instance_create_layer(0, 0, layer, oGamepad)
instance_create_layer(0, 0, layer, oCursor)

room_goto_next()
