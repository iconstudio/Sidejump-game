/// @description 캠페인 준비 팝업
close = false
scale = 0
created_time = 0
created_period = seconds(0.55)

width = 0
width_max = floor(global.resolutions_gui[0] * 0.4)
width_easing_start = 0
width_increase = 16

content_margin = 12
content_buttons_y = floor(global.resolutions_gui[1] * 0.8)
glow_scale = global.resolutions_gui[1] / 8

event_user(1)
event_user(2)
