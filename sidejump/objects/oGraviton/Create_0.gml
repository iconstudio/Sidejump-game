/// @description 초기화
status = 0

velocity_x = 0
velocity_y = 0
velocity_gravity_normal = 7.2
velocity_gravity_water = 1.5
velocity_gravity = velocity_gravity_normal

friction_x_ground = 32
friction_x_air = 2
friction_x = friction_x_ground
friction_y = 0

velocity_x_limit_normal = 800
velocity_x_limit = velocity_x_limit_normal
velocity_y_min = -800
velocity_y_max_in_gravity = 170
velocity_y_gap_in_gravity = velocity_gravity_normal * 2
velocity_y_max = 540

imxs = 1
cliffoff = false
slope_climbable = false
slope_upper_limit = 2
