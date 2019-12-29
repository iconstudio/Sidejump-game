/// @description 초기화
accel_x = 0
velocity_x = 0
velocity_y = 0

friction_x = 32 / seconds(1)
friction_x_air = friction_x * 0.1
friction_y = 0

velocity_x_limit = 420 / seconds(1)
velocity_y_min = -600 / seconds(1)
velocity_y_max_in_gravity = 320 / seconds(1)
velocity_y_gap_in_gravity = 100 / seconds(1)
velocity_y_max = 700 / seconds(1)
velocity_gravity = 20 / seconds(1)

slope_upper_limit = 3

imxs = 1
