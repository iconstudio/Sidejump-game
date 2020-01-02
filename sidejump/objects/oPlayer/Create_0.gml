event_inherited()

// 이동
accel_x = 0
velocity_movement_x = 16 / (SECOND * seconds(0.2))
velocity_movement_x_limit = 16 / SECOND
velocity_hanging = 5 / SECOND
friction_x_jumping = 8 / SECOND

NONE = 0
LEFT = -1
RIGHT = 1
BOTH = 2
solid_on_horizontal = 0 // 2: both

// 점프 시간
jump_period = seconds(0.09)
jump_time = jump_period

// 점프 속도
speed_jump_normal = 16 / jump_period
speed_jump_hang = 16 / jump_period
speed_jump_bounce = 20 / jump_period
speed_jump_rebound = 24 / jump_period
speed_jump = speed_jump_normal

// 점프 속력
velocity_jump = -270 / SECOND
velocity_jump_hang = -230 / SECOND
velocity_jump_bounce = -280 / SECOND
velocity_jump_rebound = -300 / SECOND

// 벽 밀어내기 속력
velocity_jump_push_hang = 50 / SECOND
velocity_jump_push_bounce = 200 / SECOND
velocity_jump_push_rebound = 120 / SECOND
velocity_jump_push_rebound_upper = 80 / SECOND

// 상태 플래그
jumping = false
hanging = false
dashing = false

// 좌우 이동 지연 시간
movement_delay_left_time = 0
movement_delay_right_time = 0
movement_delay_period = seconds(0.04)

// 좌우 이동 금지 시간
movement_forbid_time = 0
movement_forbid_period = seconds(0.2)
movement_forbid_period_hang = seconds(0.1)

// 점프를 이르거나 늦게 눌렀을 때도 가능하게
jump_fore_available = false
jump_fore_period = seconds(0.18)
jump_fore_time = jump_fore_period

// 점프를 땅 위에서 내려가면서 눌렀을 때도 가능하게
jump_cliffoff_period = seconds(0.08)
jump_cliffoff_time = jump_cliffoff_period

// 점프 금지 시간
jump_forbid_time = 0
jump_forbid_period = seconds(0.25)
