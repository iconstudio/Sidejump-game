/// @description 챕터 정보 그리기
var alpha_before = draw_get_alpha()

if !entry_upper.entry_upper.opened {
	var closing_ratio = 1 - entry_upper.closing_time / entry_upper.closing_period
	draw_set_alpha(alpha_before * ease_out_cubic(closing_ratio))
}

var alpha_before2 = draw_get_alpha()
if entry_upper.entry_upper.entry_choice != entry_upper {
	draw_set_alpha(draw_get_alpha() * 0.5)
	gpu_set_blendmode_ext(bm_one, bm_one)
	//gpu_set_colorwriteenable(false, false, false, true)
}

//var picture_height_max = entry_upper.chapter_board_size
if entry_upper.scale == 1 {
	draw_sprite_ext(sChapterPicture, 0, x, y, 1, 1, 0, $ffffff, draw_get_alpha())
	draw_sprite_ext(sChapterPicture, 0, x - away_distance, y + away_distance * 2, 1, 1, picture_tilt_angle, $ffffff, draw_get_alpha())
} else if 0 < entry_upper.scale {
	var rect_scale = ease_in_expo(entry_upper.scale)
	draw_sprite_ext(sChapterPicture, 0, x, y, 1, rect_scale, 0, $ffffff, draw_get_alpha())
	var rect_outspread_ratio = lerp(0, 1, rect_scale)
	var rect_x = x + rect_outspread_ratio * -away_distance
	var rect_y = y + rect_outspread_ratio * away_distance * 2
	draw_sprite_ext(sChapterPicture, 0, rect_x, rect_y, 1, rect_scale, picture_tilt_angle, $ffffff, draw_get_alpha())
}
gpu_set_blendmode(bm_normal)
//gpu_set_colorwriteenable(true, true, true, true)

draw_set_alpha(alpha_before2)
if setting_get_value("graphics") != 0
	shader_set(shaderOutline)
if entry_upper.entry_choice == id
	draw_set_color(oMainMenu.menu_entry_color_selected)
else
	draw_set_color($ffffff)
draw_set_font(fontMedium)
draw_set_halign(0)
draw_set_valign(0)
draw_text(floor(x - 40), floor(y + entry_upper.chapter_board_size * 0.6 + 24), caption)
if setting_get_value("graphics") != 0
	shader_reset()
draw_set_alpha(alpha_before)
