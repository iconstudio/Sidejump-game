/// @description menu_draw(x_begin, y_begin)
/// @function menu_draw
/// @param x_begin { real }
/// @param y_begin { real }
var x_begin = argument0
var y_begin = argument1

var alpha_before = draw_get_alpha()
for (var i = 0; i < ds_list_size(entry_list); ++i) {
	var entry = menu_get_entry(i)
	if open_time < open_period and openable and setting_get_value("graphics") != 0
		draw_set_alpha(alpha_before * ease_out_cubic(open_time / open_period))

	with entry {
		if !use_custom_coords {
			x = x_begin
			y = y_begin
		}
		if visible
			event_user(0)
		if !use_custom_coords
			y_begin += height
		if (0 < open_time and 0 < ds_list_size(entry_list)) or (!openable and entry_upper.opened) {
			if !use_custom_coords
				x_begin += oMainMenu.menu_entry_width_addition
			y_begin = menu_draw(x_begin, y_begin)
		}
	}

	draw_set_alpha(alpha_before)
	x_begin = argument0
}
return y_begin
