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
	accel_y = global.io_down - global.io_up
	#endregion
	#region presets
	if 0 < movement_preserve_time {
		velocity_x = movement_preserve_velocity
		show_debug_message(velocity_x)
		show_debug_message(movement_preserve_velocity)
	}
	var accel_direction = sign(accel_x)
	var jump_available = place_free(x, y - 1) and jump_forbid_time == 0
	var jump_execute = (global.io_pressed_jump or jump_fore_available) and jump_available
	var solid_on_left = !place_free(x - 1, y)
	var solid_on_right = !place_free(x + 1, y)
	var solid_on_left_long = false
	var solid_on_right_long = false
	var solid_on_movement = !place_free(x + movement_input, y)
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
			var velocity_x_real = velocity(velocity_x)
			solid_on_left_long = !place_free(x + velocity_x_real - 1, y)
			solid_on_right_long = !place_free(x + velocity_x_real + 1, y)
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
	if solid_on_horizontal != NONE {
		if imxs < 0
			hang_block_number = collision_line_list(bbox_left - 1, bbox_top + 1, bbox_left - 1, y, oSolidParent, false, true, hang_block_list, false)
		else
			hang_block_number = collision_line_list(bbox_right + 1, bbox_top + 1, bbox_right + 1, y, oSolidParent, false, true, hang_block_list, false)
	} else {
		hang_block_number = 0
	}
	#endregion

	// 매달리기
	if !global.io_hang
		hanging = false
	if solid_on_horizontal == imxs {
		// 양쪽에 벽이 있으면 언제든지 매달릴 수 있다.
		if global.io_hang {
			if !hanging {
				velocity_x = 0
				event_user(9)
				hanging = true
				movement_preserve_time = 0
				deaccel_hang_velocity_begin = velocity_y
				deaccel_hang_time = 0
			}
		}
	}

	if hanging {
		// 매달린 상태
		if hang_block_number == 0 {
			hanging = false
			deaccel_hang_time = 0
		} else if jump_execute {
			hanging = false

			if movement_input != 0 and !solid_on_movement {
				// 반대쪽으로 점프
				velocity_x = movement_input * velocity_move_rebound
				//player_jump(speed_jump_hang_bounce)
				player_jump_once(velocity_jump_bounce)
				player_preserve_hspeed()
				imxs = movement_input
			} else {
				if movement_input != 0 and solid_on_movement and place_free(x + movement_input, bbox_top - 4) {
					player_jump_once(velocity_jump)
				} else if global.io_up {
					player_jump_once(velocity_jump_rebound_upper)
				} else {
					player_jump_once(velocity_jump_hang)
				}
				hang_slope_time = 0
				slope_climbable = true
			}
			player_prohibit_jumping()
		} else {
			if deaccel_hang_time < deaccel_hang_period {
				velocity_y = lerp(deaccel_hang_velocity_begin, 0, deaccel_hang_time / deaccel_hang_period)
				deaccel_hang_time++
			} else {
				deaccel_hang_time = deaccel_hang_period
				velocity_y = accel_y * velocity_hanging
			}
			//velocity_y = accel_y * velocity_hanging
		}
	} else {
		#region normal
		if !solid_on_bottom
			friction_x = friction_x_air
		else
			friction_x = friction_x_ground

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
				//player_jump(speed_jump_normal)
				player_jump_once(velocity_jump)
				player_prohibit_jumping()
				player_preserve_hspeed()
			} else if solid_on_bottom or cliffoff_jump_available {
				// 바닥에 벽이 있거나 모서리 점프가 가능하다.
				//player_jump(speed_jump_normal)
				player_jump_once(velocity_jump)
			} else if solid_on_horizontal != 0 or jump_sideoff_time < jump_sideoff_period {
				// 한쪽 벽에 붙어있다.
				if solid_on_horizontal == imxs {
					// 벽을 보고 붙어있다.
					if place_free(x + imxs, y - slope_upper_limit) {
						//player_jump(speed_jump_rebound)
						player_jump_once(velocity_jump_rebound)
					} else if global.io_up {
						velocity_x = -velocity_move_rebound_upper * imxs
						//player_jump(speed_jump_rebound_upper)
						player_jump_once(velocity_jump_rebound_upper)
						player_prohibit_moving()
						player_preserve_hspeed()
					} else {
						velocity_x = -velocity_move_rebound * imxs
						//player_jump(speed_jump_rebound)
						player_jump_once(velocity_jump_rebound)
						player_prohibit_moving()
						player_preserve_hspeed()
					}
					//velocity_y = velocity_jump_rebound
					player_prohibit_jumping()
				} else { // 벽을 등지고 붙어있다.
					velocity_x = velocity_move_bounce * imxs
					if movement_input != 0
						//player_jump(speed_jump_rebound)
						player_jump_once(velocity_jump_rebound)
					else
						//player_jump(speed_jump_bounce)
						player_jump_once(velocity_jump_bounce)
					player_prohibit_moving()
					player_prohibit_jumping()
					player_preserve_hspeed()
				}
			} else {
				// 벽에 붙어있지 않다.
				if solid_on_direction {
					imxs *= -1
					velocity_x = velocity_move_bounce * imxs
					//player_jump(speed_jump_bounce)
					player_jump_once(velocity_jump_bounce)
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
	#endregion
	} // ELSE
}

if global.io_released_jump {
	
}

event_inherited()

if solid_on_bottom {
	event_user(9)

	var breakblock_when_thud = collision_point(x, bbox_bottom + 1, oBreakableBlock, false, true)
	if !dashing and !hanging {
		if instance_exists(breakblock_when_thud) {
			with breakblock_when_thud
				event_user(0)
		}
	}
} else {
	if hanging {
		if 0 < hang_block_number {
			for (var i = 0; i < hang_block_number; ++i) {
				var ablock = ds_list_find_value(hang_block_list, i)
				if instance_exists(ablock) and (ablock.object_index == oBreakableBlock or object_get_parent(ablock.object_index) == oBreakableBlock) {
					with ablock
						event_user(0)
				}
			}
		}
	}
}

if 0 < jump_forbid_time {
	if --jump_forbid_time < 0
		jump_forbid_time = 0
}

if 0 < movement_forbid_time {
	if --movement_forbid_time < 0
		movement_forbid_time = 0
}

if hang_slope_time < hang_slope_period {
	if hang_slope_period <= hang_slope_time++
		hang_slope_time = hang_slope_period
} else {
	hang_slope_time = hang_slope_period
	slope_climbable = false
}

if 0 < movement_preserve_time {
	if --movement_preserve_time < 0
		movement_preserve_time = 0
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
