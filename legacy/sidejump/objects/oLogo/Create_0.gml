/// @description 로고
gui_cx = global.resolutions_gui[0] * 0.5
gui_cy = global.resolutions_gui[1] * 0.5
x = gui_cx
y = gui_cy

draw_set_color($ffffff)

info_caption_copyright = "copyright 2020 iconstudio"
info_caption_version = "version " + GM_version
info_drawn_y = global.resolutions_gui[1] - 4
info_time = 0
info_period = seconds(0.8)

alarm[0] = seconds(1)
