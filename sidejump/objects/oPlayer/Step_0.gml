var movement_input = global.io_right - global.io_left
if movement_input != 0 {
	movement_time++
	imxs = movement_input
} else {
	movement_time = 0
}

if (movement_period <= movement_time and movement_input != 0 and movement_forbid_time == 0) {
	accel_x = movement_input
	velocity_x = mean(accel_x * velocity_movement, velocity_x)
} else {
	accel_x = 0
}

event_inherited()

if global.io_pressed_jump {
	jump_fore_time = 0
}
jump_fore_available = jump_fore_time < jump_fore_period

var solid_on_left = !place_free(x - 1, y)
var solid_on_right = !place_free(x + 1, y)
var solid_on_bottom = !place_free(x, y + 1)
if solid_on_left and solid_on_right
	solid_on_horizontal = 2
else if solid_on_left and !solid_on_right
	solid_on_horizontal = -1
else if !solid_on_left and solid_on_right
	solid_on_horizontal = 1
else
	solid_on_horizontal = 0

if solid_on_bottom
	jumping = false

if !dashing {
	// 매달리기
	hanging = false
	if accel_x != 0 and accel_x == imxs {
		// 양쪽에 벽이 있으면 언제든지 매달릴 수 있다.
		if solid_on_horizontal == accel_x or solid_on_horizontal == 2
			hanging = true
	}

	if (global.io_pressed_jump or jump_fore_available) and place_free(x, y - 1) and jump_forbid_time == 0 {
		if solid_on_bottom or solid_on_horizontal != 0 {
			if solid_on_bottom or solid_on_horizontal == 2 {
				velocity_y = velocity_jump
				jumping = true
			} else if hanging {
				velocity_x += -velocity_jump_push_hang * imxs
				velocity_y = velocity_jump_hang
				hanging = false
				movement_forbid_time = movement_forbid_period_short
				jump_forbid_time = jump_forbid_period
				jumping = true
				show_debug_message(velocity_x)
			} else if solid_on_horizontal != 0 {
				if solid_on_horizontal == imxs { // 벽을 보고 붙어있다.
					if movement_input == -solid_on_horizontal { // 벽과 반대 방향으로 움직이려고 한다.
						// 이미 반대 방향을 보고 있다.
						velocity_x += velocity_jump_push_bounce * imxs
						velocity_y = velocity_jump_bounce
						movement_forbid_time = movement_forbid_period
					} else {
						velocity_x += -velocity_jump_push_rebound * imxs
						velocity_y = velocity_jump_rebound
					}
					jumping = true
				} else { // 벽을 등지고 붙어있다.
					velocity_x += velocity_jump_push_bounce * imxs
					velocity_y = velocity_jump_bounce
					movement_forbid_time = movement_forbid_period
					jumping = true
				}
			}

			if jumping
				jump_fore_time = jump_fore_period
		}
	}

	if jumping and velocity_y < 0 and global.io_released_jump {
		velocity_y *= 0.4
	}

	if hanging and 0 <= velocity_y
		velocity_y = mean(velocity_hanging, velocity_y)
} else {
	friction_y = 0
}

if 0 < jump_forbid_time
	jump_forbid_time--
else
	jump_forbid_time = 0

if 0 < movement_forbid_time
	movement_forbid_time--
else
	movement_forbid_time = 0

if jump_fore_time < jump_fore_period
	jump_fore_time++
else
	jump_fore_time = jump_fore_period

if accel_x != 0
	accel_x = 0
