if global.io_pressed_jump {
	jump_fore_time = 0
	jump_fore_available = true
}
velocity_gravity = velocity_gravity_normal
if cliffoff {
	jump_cliffoff_time = 0
	cliffoff = false
}

if dashing {
	// 대시 중인 상태
	
} else {
	//velocity_x_limit = velocity_movement_x_limit
	#region inputs for horizontal
	var movement_input = global.io_right - global.io_left
	if movement_input != 0 {
		if movement_input == -1
			movement_delay_left_time++
		else
			movement_delay_left_time = 0

		if movement_input == 1
			movement_delay_right_time++
		else
			movement_delay_right_time = 0

		imxs = movement_input
	} else {
		movement_delay_left_time = 0
		movement_delay_right_time = 0
	}

	if movement_input != 0 and movement_forbid_time == 0 {
		if movement_delay_period <= movement_delay_left_time
			accel_x = -velocity_movement_x
		else if movement_delay_period <= movement_delay_right_time
			accel_x = velocity_movement_x
		else
			accel_x = 0
	} else {
		accel_x = 0
	}
	#endregion
	#region presets
	var accel_direction = sign(accel_x)
	var jump_available = place_free(x, y - 1) and jump_forbid_time == 0
	var jump_execute = (global.io_pressed_jump or jump_fore_available) and jump_available
	var solid_on_left = !place_free(x - 1, y)
	var solid_on_right = !place_free(x + 1, y)
	var solid_on_left_long = false
	var solid_on_right_long = false
	var solid_on_bottom = !place_free(x, y + 1)
	if solid_on_left and solid_on_right {
		solid_on_horizontal = BOTH
	} else {
		if solid_on_left and !solid_on_right
			solid_on_horizontal = LEFT
		else if !solid_on_left and solid_on_right
			solid_on_horizontal = RIGHT
		else
			solid_on_horizontal = NONE

		if velocity_x != 0 {
			solid_on_left_long = !place_free(x + velocity_x - 1, y)
			solid_on_right_long = !place_free(x + velocity_x + 1, y)
		} else {
			solid_on_left_long = solid_on_left
			solid_on_right_long = solid_on_right
		}
	}
	var solid_on_both = solid_on_horizontal == BOTH
	#endregion

	// 매달리기
	hanging = false
	if accel_x != 0 and accel_direction == imxs and jump_period <= jump_time {
		// 양쪽에 벽이 있으면 언제든지 매달릴 수 있다.
		if solid_on_horizontal == accel_direction or solid_on_both {
			jumping = false
			hanging = true
		}
	}

	if hanging {
		// 매달린 상태
		if jump_execute {
			if !solid_on_both and !solid_on_bottom
				velocity_x -= velocity_jump_push_hang * imxs
			//velocity_y = velocity_jump_hang
			jumping = true
			hanging = false
			speed_jump = speed_jump_hang
			jump_time = 0
			movement_forbid_time = movement_forbid_period_hang
			jump_forbid_time = jump_forbid_period
			show_debug_message(velocity_x)
		} else {
			if 0 <= velocity_y
				velocity_y = mean(velocity_hanging, velocity_y)
		}
	} else {
		// 일반 상태
		if accel_x != 0 {
			if abs(velocity_x) < velocity_movement_x_limit or velocity_x * accel_direction <= 0
				velocity_x += accel_x
			//else
			//	velocity_x_limit = velocity_movement_x_limit
		}

		if jump_time < jump_period {
			velocity_y = -speed_jump
			velocity_gravity = 0
		}

		if jump_execute {
			var cliffoff_jump_available = jump_cliffoff_time < jump_cliffoff_period
			if solid_on_both {
				// 양쪽에 벽이 있다.
				velocity_x = 0
				//velocity_y = velocity_jump
				jumping = true
				speed_jump = speed_jump_normal
				jump_time = 0
				jump_forbid_time = jump_forbid_period
			} else if solid_on_bottom or cliffoff_jump_available {
				// 바닥에 벽이 있거나 모서리 점프가 가능하다.
				if velocity_x != 0
					velocity_x += velocity_movement_x * sign(velocity_x) * 3
				//velocity_y = velocity_jump
				speed_jump = speed_jump_normal
				jump_time = 0
				jumping = true
			} else if solid_on_horizontal != 0 {
				// 한쪽 벽에 붙어있다.
				if solid_on_horizontal == imxs {
					// 벽을 보고 붙어있다.
					velocity_x += -velocity_jump_push_rebound * imxs
					//velocity_y = velocity_jump_rebound
					speed_jump = speed_jump_rebound
					jump_time = 0
					jumping = true
					movement_forbid_time = movement_forbid_period_hang
					jump_forbid_time = jump_forbid_period
				} else { // 벽을 등지고 붙어있다.
					velocity_x += velocity_jump_push_bounce * imxs
					if movement_input != 0
						//velocity_y = velocity_jump_rebound
						speed_jump = speed_jump_rebound
					else
						//velocity_y = velocity_jump_bounce
						speed_jump = speed_jump_bounce
					jump_time = 0
					jumping = true
					movement_forbid_time = movement_forbid_period
					jump_forbid_time = jump_forbid_period
				}
			} else {
				// 벽에 붙어있지 않다.
				
			}

			if jumping {
				jump_fore_time = jump_fore_period
				jump_fore_available = false
				cliffoff = false
			}
		} // IF jump_execute
	} // ELSE
}

//if global.io_released_jump {
//	jump_time = jump_period
//}

event_inherited()

if solid_on_bottom
	jumping = false

if 0 < jump_forbid_time
	jump_forbid_time--
else
	jump_forbid_time = 0

if 0 < movement_forbid_time
	movement_forbid_time--
else
	movement_forbid_time = 0

if jump_time < jump_period
	jump_time++
else
	jump_time = jump_period

if jump_fore_time < jump_fore_period {
	jump_fore_time++
} else {
	jump_fore_time = jump_fore_period
	jump_fore_available = false
}

if jump_cliffoff_time < jump_cliffoff_period
	jump_cliffoff_time++
else
	jump_cliffoff_time = jump_cliffoff_period

if accel_x != 0
	accel_x = 0
