/// @description 로딩 메시지 출력
draw_set_font(fontLarge)
draw_set_color($ffffff)
draw_set_halign(1)
draw_set_valign(1)

if loading_failed {
	draw_text(480, 240, "Loading failed.")
} else {
	draw_text(480, 440, string(audio_group_load_progress(audiogroup_everthing)) + " / 100")
}


