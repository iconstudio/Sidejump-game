/// @description 디버그
if global.flag_debug {
	draw_set_alpha(1)
	draw_set_color($ffffff)
	draw_set_font(fontSmall)
	draw_set_halign(0)
	draw_set_valign(0)
	draw_text(10, 10, room_get_name(room))
	draw_text(10, 28, string(fps) + " / " + string(room_speed))
}

