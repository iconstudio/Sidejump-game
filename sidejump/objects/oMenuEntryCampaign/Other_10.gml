var alpha_before = draw_get_alpha()
draw_set_alpha(alpha_before * 0.4)
draw_set_color(0)
if 0 < scale and scale < 1 {
	var opening_ratio = entry_upper.open_time / entry_upper.open_period
	var opening_height = lerp(0, height * 0.5, ease_in_expo(opening_ratio))
	draw_rectangle_size(0, y + board_y_half, global.resolutions_gui[0], -opening_height, false)
	draw_rectangle_size(0, y + board_y_half + 1, global.resolutions_gui[0], opening_height, false)
} else {
	draw_rectangle_size(0, y + board_y, global.resolutions_gui[0], board_height, false)
}

draw_set_alpha(alpha_before)
//draw_rectangle_size(board_content_x_beign, y, chapter_board_size, chapter_board_size, false)

draw_set_alpha(alpha_before)
