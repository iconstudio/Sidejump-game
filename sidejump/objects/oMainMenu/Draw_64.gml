/// @description 메뉴 그리기

draw_set_font(fontSmall)
draw_set_valign(2)
draw_set_halign(0)
if info_brand_time < info_brand_period {
	draw_text(4, info_drawn_y, info_caption_copyright)
	draw_set_alpha(lerp(0, 1, ease_in_cubic(info_brand_time / info_brand_period)))
	draw_text(info_brand_drawn_x, info_drawn_y, info_caption_brand)
	draw_set_alpha(1)
} else {
	draw_text(4, info_drawn_y, info_caption_brand_full)
}

draw_set_halign(2)
draw_text(global.resolutions_gui[0] - 4, info_drawn_y, info_caption_version)
draw_set_alpha(1)
