event_inherited()

movement_delay_left_time = 0
movement_delay_right_time = 0
movement_delay_period = seconds(0.07)
movement_forbid_time = 0
movement_forbid_period = seconds(0.3)
movement_forbid_period_hang = seconds(0.04)

velocity_movement = 20 / seconds(1)
velocity_movement_limit = 110 / seconds(1)

velocity_hanging = 30 / seconds(1)
solid_on_horizontal = 0 // 2: both

// 점프를 이르거나 늦게 눌렀을 때도 가능하게
jump_fore_available = false
jump_fore_period = seconds(0.1)
jump_fore_time = jump_fore_period
// 점프를 땅 위에서 내려가면서 눌렀을 때도 가능하게
jump_cliffoff_period = seconds(0.08)
jump_cliffoff_time = jump_cliffoff_period

jump_forbid_time = 0
jump_forbid_period = seconds(0.25)
velocity_jump = -290 / seconds(1)
velocity_jump_hang = -260 / seconds(1)
velocity_jump_bounce = -270 / seconds(1)
velocity_jump_rebound = -310 / seconds(1)
velocity_jump_push_hang = 50 / seconds(1)
velocity_jump_push_bounce = 190 / seconds(1)
velocity_jump_push_rebound = 140 / seconds(1)

jumping = false
hanging = false
dashing = false
