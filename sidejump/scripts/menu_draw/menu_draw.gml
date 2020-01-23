/// @description menu_draw(x_begin, y_begin)
/// @function menu_draw
/// @param x_begin { real }
/// @param y_begin { real }
var x_begin = argument0
var y_begin = argument1

for (var i = 0; i < ds_list_size(entry_list); ++i) {
	var entry = entry_list[| i]
	if entry_choice_index == i
		draw_set_color($a502fb)
	else
		draw_set_color($ffffff)
	with entry {
		draw_text(x_begin, y_begin, caption)
		y_begin += height

		if opened and 0 < ds_list_size(entry_list) {
			x_begin += menu_entry_width_addition
			y_begin = menu_draw(x_begin, y_begin)
		}
	}

	x_begin = argument0
}
return y_begin
