event_inherited()

movement_forbid_time = 0
movement_forbid_period = seconds(0.3)
movement_forbid_period_short = seconds(0.1)
movement_time = 0
movement_period = seconds(0.07)
velocity_movement = 130 / seconds(1)

velocity_hanging = 30 / seconds(1)
solid_on_horizontal = 0 // 2: both

jump_forbid_time = 0
jump_forbid_period = seconds(0.25)
velocity_jump = -320 / seconds(1)
velocity_jump_hang = -250 / seconds(1)
velocity_jump_bounce = -300 / seconds(1)
velocity_jump_push_hang = 110 / seconds(1)
velocity_jump_push_bounce = 160 / seconds(1)
velocity_jump_push_rebound = 140 / seconds(1)

jumping = false
hanging = false
dashing = false
