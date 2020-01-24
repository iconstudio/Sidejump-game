/// @description 그리기
if custom_x != -1
	x = custom_x
if custom_y != -1
	y = custom_y

draw_set_font(fontMenuMedium)
draw_set_halign(1)
draw_set_valign(1)
var scale = 1
if 0 < open_time {
	if opened
		scale = lerp(1, oMainMenu.menu_entry_font_scale, ease_out_expo(open_time / open_period))
	else
		scale = lerp(1, oMainMenu.menu_entry_font_scale, ease_in_expo(open_time / open_period))
}

var scale_big = scale * 1.03
var caption_drawn_x = x + width * 0.5
var caption_drawn_y = y + height * 0.5
draw_set_color(0)
draw_text_transformed(caption_drawn_x - 2, caption_drawn_y, caption, scale_big, scale_big, 0)
draw_text_transformed(caption_drawn_x, caption_drawn_y - 2, caption, scale_big, scale_big, 0)
draw_text_transformed(caption_drawn_x + 2, caption_drawn_y, caption, scale_big, scale_big, 0)
draw_text_transformed(caption_drawn_x, caption_drawn_y + 2, caption, scale_big, scale_big, 0)

if entry_upper.entry_choice == id
	draw_set_color(oMainMenu.menu_entry_color_selected)
else
	draw_set_color($ffffff)
draw_text_transformed(caption_drawn_x, caption_drawn_y, caption, scale, scale, 0)
