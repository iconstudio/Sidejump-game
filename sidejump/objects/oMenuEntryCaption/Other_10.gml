/// @description 그리기
if draw_get_alpha() <= 0
	exit

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

var _caption, _width = surface_get_width(caption_surface), _height = surface_get_height(caption_surface)
if script_exists(info_predicate) {
	_caption = caption + script_execute(info_predicate)
	_width = string_width(_caption)
	_height = string_height(_caption)
} else {
	_caption = caption
	_width = width
	_height = height
}


var alpha_before = draw_get_alpha()
draw_set_alpha(1)
if entry_upper.entry_choice == id
	draw_set_color(oMainMenu.menu_entry_color_selected)
else
	draw_set_color($ffffff)

draw_set_alpha(alpha_before)

if setting_get_value("graphics") != 0 {
	shader_set(shaderOutline)
}
draw_text_transformed(x, y, _caption, scale, scale, 0)
if setting_get_value("graphics") != 0 {
	shader_reset()
}
