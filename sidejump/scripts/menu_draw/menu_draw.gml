/// @description menu_draw(x_begin, y_begin)
/// @function menu_draw
/// @param x_begin { real }
/// @param y_begin { real }
var x_begin = argument0
var y_begin = argument1

for (var i = 0; i < ds_list_size(entry_list); ++i) {
	var entry = entry_list[| i]
	var alpha_before = draw_get_alpha()

	if object_index != oMainMenu {
		if open_time < open_period
			draw_set_alpha(alpha_before * ease_out_quad(open_time / open_period))
	}
	with entry {
		x = x_begin
		y = y_begin
		event_user(0)
		if custom_y == -1
			y_begin += height
		if opened and 0 < ds_list_size(entry_list) {
			if custom_x == -1
				x_begin += oMainMenu.menu_entry_width_addition
			y_begin = menu_draw(x_begin, y_begin)
		}
	}

	x_begin = argument0
	draw_set_alpha(alpha_before)
}
return y_begin