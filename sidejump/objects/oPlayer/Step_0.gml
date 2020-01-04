if global.io_pressed_jump {
	jump_fore_time = 0
	jump_fore_available = true
}

if cliffoff {
	jump_cliffoff_time = 0
	cliffoff = false
}

if dashing {
	// 대시 중인 상태
	
} else {
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

		if !hanging
			imxs = movement_input
	} else {
		movement_delay_left_time = 0
		movement_delay_right_time = 0
	}

	if movement_input != 0 and movement_forbid_time == 0 {
		if movement_delay_period <= movement_delay_left_time
			accel_x = -1
		else if movement_delay_period <= movement_delay_right_time
			accel_x = 1
		else
			accel_x = 0
	} else {
		accel_x = 0
	}
	#endregion
	#region inputs for vertical
	var vetical_input = global.io_down - global.io_up
	if movement_input != 0 and movement_forbid_time == 0 {
		accel_y = vetical_input
	} else {
		accel_y = 0
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
	var solid_on_direction = false
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
		if velocity_x != 0 {
			if (solid_on_left_long and velocity_x < 0) or (solid_on_right_long and 0 < velocity_x)
				solid_on_direction = true
		}
	}
	var solid_on_both = solid_on_horizontal == BOTH
	if movement_preserve_time == 0
		velocity_x_limit = velocity_x_limit_normal
	else
		velocity_x_limit = movement_preserve_velocity
	#endregion

	// 매달리기
	hanging = false
	if global.io_hang and jump_period <= jump_time and 0 <= velocity_y {
		// 양쪽에 벽이 있으면 언제든지 매달릴 수 있다.
		if solid_on_horizontal == imxs {
			jumping = false
			hanging = true
		}
	}

	if hanging {
		// 매달린 상태
		if jump_execute {
			//velocity_y = velocity_jump_hang
			hanging = false

			if movement_input != 0 and place_free(x + movement_input, y) {
				// 반대쪽으로 점프
				velocity_x = movement_input * velocity_jump_push_rebound
				player_jump(speed_jump_hang_bounce)
				imxs = movement_input
			} else {
				player_jump(speed_jump_hang)
				player_prohibit_moving()
			}
			player_prohibit_jumping()
			player_preserve_hspeed()
		} else {
			velocity_y = movement_input * velocity_hanging
		}
	} else {
		// 일반 상태
		if accel_x != 0 {
			// 이동
			if sign(velocity_x) != accel_direction {
				velocity_x += accel_x * velocity_movement_x
			} else {
				if velocity_movement_x_limit < abs(velocity_x) {
					if solid_on_bottom
						velocity_x -= friction_x_ground * sign(velocity_x)
					else
						velocity_x -= friction_x_air_for_accel * sign(velocity_x)
				} else {
					var accel_check = abs(velocity_x) <= velocity_movement_x_limit
					velocity_x += accel_x * velocity_movement_x
					if accel_check and velocity_movement_x_limit < abs(velocity_x)
						velocity_x = velocity_movement_x_limit * sign(velocity_x)
				}
			}
		}
		if jump_execute {
			var cliffoff_jump_available = jump_cliffoff_time < jump_cliffoff_period
			if solid_on_both {
				// 양쪽에 벽이 있다.
				velocity_x = 0
				//velocity_y = velocity_jump
				player_jump(speed_jump_normal)
				player_prohibit_jumping()
				player_preserve_hspeed()
			} else if solid_on_bottom or cliffoff_jump_available {
				// 바닥에 벽이 있거나 모서리 점프가 가능하다.
				//velocity_y = velocity_jump
				player_jump(speed_jump_normal)
			} else if solid_on_horizontal != 0 or jump_sideoff_time < jump_sideoff_period {
				// 한쪽 벽에 붙어있다.
				if solid_on_horizontal == imxs {
					// 벽을 보고 붙어있다.
					if place_free(x + imxs, y - slope_upper_limit) {
						player_jump(speed_jump_rebound)
					} else if global.io_up {
						velocity_x = -velocity_jump_push_rebound_upper * imxs
						player_jump(speed_jump_rebound_upper)
						player_prohibit_moving()
						player_preserve_hspeed()
					} else {
						velocity_x = -velocity_jump_push_rebound * imxs
						player_jump(speed_jump_rebound)
						player_prohibit_moving()
						player_preserve_hspeed()
					}
					//velocity_y = velocity_jump_rebound
					player_prohibit_jumping()
				} else { // 벽을 등지고 붙어있다.
					velocity_x = velocity_jump_push_bounce * imxs
					if movement_input != 0
						player_jump(speed_jump_rebound)
						//velocity_y = velocity_jump_rebound
					else
						player_jump(speed_jump_bounce)
						//velocity_y = velocity_jump_bounce
					player_prohibit_moving()
					player_prohibit_jumping()
					player_preserve_hspeed()
				}
			} else {
				// 벽에 붙어있지 않다.
				if solid_on_direction {
					imxs *= -1
					velocity_x = velocity_jump_push_bounce * imxs
					player_jump(speed_jump_bounce)
					player_prohibit_moving()
					player_preserve_hspeed()
				}
			}

			if jumping {
				jump_fore_time = jump_fore_period
				jump_fore_available = false
				cliffoff = false
			}
		} // IF jump_execute

		if jump_time < jump_period {
			velocity_y = -speed_jump
			velocity_gravity = 0
		}
	} // ELSE
}

if global.io_released_jump {
	jump_time = jump_period
}

event_inherited()

if solid_on_bottom {
	if jumping {
		jumping = false
	}
	movement_forbid_time = 0
	jump_forbid_time = 0
	movement_preserve_time = 0
	jump_sideoff_time = jump_sideoff_period
	jump_cliffoff_time = jump_cliffoff_period
}

if 0 < jump_forbid_time {
	if --jump_forbid_time < 0
		jump_forbid_time = 0
}

if 0 < movement_forbid_time {
	if --movement_forbid_time < 0
		movement_forbid_time = 0
}

if 0 < movement_preserve_time {
	if --movement_preserve_time < 0
		movement_preserve_time = 0
}

if jump_time < jump_period {
	if jump_period < ++jump_time
		jump_time = jump_period
} else {
	velocity_gravity = velocity_gravity_normal
}

if jump_sideoff_time < jump_sideoff_period {
	if jump_sideoff_period < ++jump_sideoff_time
		jump_sideoff_time = jump_sideoff_period
}

if jump_fore_available {
	if jump_fore_period <= ++jump_fore_time {
		jump_fore_time = jump_fore_period
		jump_fore_available = false
	}
}

if jump_cliffoff_time < jump_cliffoff_period {
	if jump_cliffoff_period < ++jump_cliffoff_time
		jump_cliffoff_time = jump_cliffoff_period
}
