var alpha_before = draw_get_alpha()
draw_set_alpha(alpha_before * 0.4)
draw_set_color(0)
draw_rectangle_size(0, y + board_y, global.resolutions_gui[0], board_height, false)

draw_set_alpha(alpha_before)
draw_rectangle_size(0, y, chapter_board_size, chapter_board_size, false)

draw_set_alpha(alpha_before)
