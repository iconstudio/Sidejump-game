event_inherited()

// 수평 이동
accel_x = 0
velocity_movement_x = 32
velocity_movement_x_limit = 100

friction_x_air = 8
friction_x_air_for_accel = 10

// 매달리기
deaccel_hang_velocity_begin = 0
deaccel_hang_time = 0
deaccel_hang_period = seconds(0.16)

// 수직 이동
accel_y = 0
velocity_hanging = 4

// 점프 속도
velocity_jump = -175
velocity_jump_hang = -120
velocity_jump_hang_upper = -150
velocity_jump_bounce = -180
velocity_jump_rebound = -180
velocity_jump_rebound_upper = -200

// 벽 밀어내기 속력
velocity_move_bounce = 125
velocity_move_rebound = 110
velocity_move_rebound_upper = 48

// 상태 플래그
jumping = false
hanging = false
dashing = false

// 좌우 이동 지연 시간
movement_delay_left_time = 0
movement_delay_right_time = 0
movement_delay_period = seconds(0.04)

// 좌우 속도 유지 시간
movement_preserve_velocity = 0
movement_preserve_time = 0
movement_preserve_period = seconds(0.44)
movement_preserve_period_spring = seconds(0.3)

// 좌우 이동 금지 시간
movement_forbid_time = 0
movement_forbid_period = seconds(0.2)

// 매달리고 난 후에는 경사로를 다닐 수 있게
hang_slope_time = 0
hang_slope_period = seconds(1.1)

// 벽에서 잠시 떨어졌을 때도 벽 점프가 가능하게
jump_sideoff_period = seconds(0.1)
jump_sideoff_time = jump_sideoff_period

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

NONE = 0
LEFT = -1
RIGHT = 1
BOTH = 2
solid_on_horizontal = 0 // 2: both
hang_block_number = 0
hang_block_list = ds_list_create()
