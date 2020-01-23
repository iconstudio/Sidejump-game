/// @description 메뉴 그리기
draw_set_halign(0)
draw_set_valign(0)
if 0 < main_alpha {
	draw_set_alpha(main_alpha)
	var entry_drawn_x = menu_drawn_x_begin
	var entry_drawn_y = menu_drawn_y_begin
	var entry_drawn_pos = menu_draw(entry_drawn_x, entry_drawn_y)
	draw_set_alpha(1)
}


