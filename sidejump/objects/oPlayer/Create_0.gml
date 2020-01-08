event_inherited()

// 수평 이동
accel_x = 0
velocity_movement_x = 16 / SECOND
velocity_movement_x_limit = 84 / SECOND
velocity_x_limit_normal = 160 / SECOND
friction_x_air = 16 / SECOND
friction_x_air_for_accel = 8 / SECOND

// 매달리기
deaccel_hang_velocity_begin = 0
deaccel_hang_time = 0
deaccel_hang_period = seconds(0.1)
deaccel_grab_velocity = 6 / SECOND
deaccel_grab_period = seconds(0.3)

// 수직 이동
accel_y = 0
velocity_hanging = 16 / SECOND

// 점프 시간
jump_period = seconds(0.08)
jump_time = jump_period

// 점프 속도
speed_jump_normal = 11 / jump_period
speed_jump_hang = 11 / jump_period
speed_jump_bounce = 13 / jump_period
speed_jump_hang_bounce = 13 / jump_period
speed_jump_rebound = 12 / jump_period
speed_jump_rebound_upper = 13 / jump_period
speed_jump = speed_jump_normal

// 점프 속력
velocity_jump = -270 / SECOND
velocity_jump_hang = -230 / SECOND
velocity_jump_bounce = -280 / SECOND
velocity_jump_rebound = -300 / SECOND

// 벽 밀어내기 속력
velocity_jump_push_bounce = 128 / SECOND
velocity_jump_push_rebound = 100 / SECOND
velocity_jump_push_rebound_upper = 72 / SECOND

// 상태 플래그
jumping = false
grabbing = false
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

// 좌우 이동 금지 시간
movement_forbid_time = 0
movement_forbid_period = seconds(0.2)

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
