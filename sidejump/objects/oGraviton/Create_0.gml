/// @description 초기화
status = 0

velocity_x = 0
velocity_y = 0
velocity_gravity_normal = 16 / SECOND
velocity_gravity = velocity_gravity_normal

cliffoff = false
slope_upper_limit = 3

friction_x_normal = 8 / SECOND
friction_x_air = 1 / SECOND
friction_x = friction_x_normal
friction_y = 0

velocity_x_limit_normal = 320 / SECOND
velocity_x_limit = velocity_x_limit_normal
velocity_y_min = -400 / SECOND
velocity_y_max_in_gravity = 240 / SECOND
velocity_y_gap_in_gravity = velocity_gravity_normal * 2
velocity_y_max = 400 / SECOND

imxs = 1
