draw_sprite(sLogo, 0, x, y)

draw_set_font(fontIntros)
draw_set_halign(1)
draw_set_valign(0)
draw_text(x, y + 140, "iconstudio")

draw_set_alpha(lerp(0, 1, ease_out_circ(info_time / info_period)))
draw_set_font(fontSmall)
draw_set_valign(2)
draw_set_halign(0)
draw_text(4, info_drawn_y, info_caption_copyright)

draw_set_halign(2)
draw_text(global.resolutions_gui[0] - 4, info_drawn_y, info_caption_version)
draw_set_alpha(1)
