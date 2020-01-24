gui_cx = global.resolutions_gui[0] * 0.5
gui_cy = global.resolutions_gui[1] * 0.5

image_alpha = 0
alpha_target = 0.6
alpha_time = 0
alpha_period = seconds(1)
text_alpha = 0
text_alpha_time = 0
text_alpha_period = seconds(0.9)

alpha_shroud_fall = true
alpha_shroud_y = 0
alpha_shroud_duration = seconds(3.8)
alpha_shroud_gravity = global.resolutions_gui[1] / alpha_shroud_duration
alpha_shroud_speed = alpha_shroud_gravity * 0.5
alpha_shroud_speed_min = alpha_shroud_gravity * 0.02

deadend = false
textout_time = 0
textout_period = seconds(0.5)
fadeout = false
fadeout_time = 0
fadeout_period = seconds(0.4)

selection = 1
selection_surface = -1
