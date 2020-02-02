/// @description 그리기
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
var caption_drawn_x = x// + _width * 0.5
var caption_drawn_y = y// + _height * 0.5
if setting_get_value("graphics") == 2
	shader_set(shaderOutline)
if entry_upper.entry_choice == id
	draw_set_color(oMainMenu.menu_entry_color_selected)
else
	draw_set_color($ffffff)
draw_text_transformed(caption_drawn_x, caption_drawn_y, _caption, scale, scale, 0)
if setting_get_value("graphics") == 2
	shader_reset()
