/// @description 그리기
if draw_get_alpha() <= 0
	exit

if !surface_exists(caption_surface)
	event_user(1)

if use_custom_coords {
	x = custom_x
	y = custom_y
}

draw_set_font(fontMenu)
draw_set_halign(0)
draw_set_valign(0)
var scale = 1
if 0 < open_time {
	if opened
		scale = lerp(1, oMainMenu.menu_entry_font_scale, ease_out_expo(open_time / open_period))
	else
		scale = lerp(1, oMainMenu.menu_entry_font_scale, ease_in_expo(open_time / open_period))
}

var _caption, _width, _height
if script_exists(info_predicate) {
	_caption = caption + script_execute(info_predicate)
	_width = string_width(_caption)
	_height = string_height(_caption)
} else {
	_caption = caption
	_width = width
	_height = height
}
if surface_get_width(caption_surface) != _width or surface_get_height(caption_surface) != _height
	surface_resize(caption_surface, _width, _height)

var alpha_before = draw_get_alpha()
draw_set_alpha(1)
if entry_upper.entry_choice == id
	draw_set_color(oMainMenu.menu_entry_color_selected)
else
	draw_set_color($ffffff)

surface_set_target(caption_surface)
draw_clear_alpha(0, 0)
draw_text(0, 0, _caption)
surface_reset_target()

draw_set_alpha(alpha_before)

if setting_get_value("graphics") != 0 {
	shader_set(shaderOutline)
	shader_set_uniform_f(global.shaderOutline_resolution, _width, _height)
}
draw_surface_ext(caption_surface, floor(x), floor(y), scale, scale, 0, $ffffff, draw_get_alpha())
if setting_get_value("graphics") != 0 {
	shader_set_uniform_f(global.shaderOutline_resolution, global.application_sizes[0], global.application_sizes[1])
	shader_reset()
}
