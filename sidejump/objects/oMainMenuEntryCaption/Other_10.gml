/// @description 그리기
if custom_x != -1
	x = custom_x
if custom_y != -1
	y = custom_y

if entry_upper.entry_choice == id
	draw_set_color(oMainMenu.menu_entry_color_selected)
else
	draw_set_color($ffffff)

var scale = 1
if open_time == 0 {
	draw_set_font(fontMenuMedium)
} else {
	draw_set_font(fontMenuLarge)
	if opened
		scale = lerp(oMainMenu.menu_entry_font_scale, 1, ease_out_expo(open_time / open_period))
	else
		scale = lerp(oMainMenu.menu_entry_font_scale, 1, ease_in_expo(open_time / open_period))
}
draw_text_transformed(x, y, caption, scale, scale, 0)
