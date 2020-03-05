/// @description 이동 및 펼치기
event_inherited()

y = entry_upper.y + entry_upper.board_content_y + 50

if entry_upper.chapter_board_await_period <= entry_upper.chapter_board_await_time
and entry_upper.entry_upper.opened {
	if move_await_time < move_await_period {
		move_await_time++
	} else if popin_time < popin_period {
		var popin_ratio = ease_in_out_back(popin_time / popin_period)
		x = lerp(move_begin_x, move_target_x + entry_upper.chapter_board_scroll, popin_ratio)
		popin_time++
	} else {
		x += (move_target_x + entry_upper.chapter_board_scroll - x) * 0.06

		picture_tilt_angle = lerp(0, picture_tilt_angle_max, picture_tilt_time / picture_tilt_period)
		if entry_upper.entry_choice == id {
			if picture_tilt_time < picture_tilt_period {
				picture_tilt_time++
			} else {
				picture_tilt_time = picture_tilt_period
			}

			if picture_glow_await_time < picture_glow_await_period {
				picture_glow_await_time++
			} else {
				picture_glow_await_time = picture_glow_await_period
				if picture_glow_time < picture_glow_period {
					picture_glow_time++
				} else {
					picture_glow_time = picture_glow_period
				}
			}
		} else {
			picture_glow_await_time = 0
			picture_glow_time = 0

			if 0 < picture_tilt_time {
				picture_tilt_time--
			} else {
				picture_tilt_time = 0
			}
		}
	}
} else {
	picture_tilt_angle = lerp(0, picture_tilt_angle_max, picture_tilt_time / picture_tilt_period)
	if 0 < picture_tilt_time {
		picture_tilt_time--
	} else {
		picture_tilt_time = 0
	}
}
