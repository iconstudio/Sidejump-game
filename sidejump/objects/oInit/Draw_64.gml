/// @description 로딩 메시지 출력
draw_set_font(fontLarge)
draw_set_color($ffffff)
draw_set_halign(1)
draw_set_valign(1)

var dx = global.resolutions_default[0] * 0.5
var dy = global.resolutions_default[1]
if loading_failed {
	draw_text(dx, dy * 0.5, "Loading failed.")
} else {
	draw_text(dx, dy * 0.9, string(audio_group_load_progress(audiogroup_everthing)) + " / 100")
}


