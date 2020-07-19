event_inherited()

scale = entry_upper.open_time / entry_upper.open_period
if !entry_upper.opened {
	height = lerp(0, height_max, ease_in_expo(scale))
	if entry_upper.open_time == 0 // 닫힌 상태
		await_time = 0
} else if scale < 1 {
	height = lerp(0, height_max, ease_out_quad(scale))
} else {
	height = height_max

	if await_time < await_period {
		await_time++
	} else if entry_upper.entry_choice == id {
		var check_menu_lf = global.io_pressed_left
		var check_menu_rt = global.io_pressed_right
		var check_menu_return = global.io_pressed_yes or global.io_pressed_no
		
		if check_menu_lf xor check_menu_rt {
			if check_menu_lf {
				if value == value_min {
					if can_wrap
						value = value_max
				} else {
					value = min(max(value - 1, value_min), value_max)
				}
				if script_exists(callback)
					script_execute(callback, value)
			} else if check_menu_rt {
				if value == value_max {
					if can_wrap
						value = value_min
				} else {
					value = min(value + 1, value_max)
				}
				if script_exists(callback)
					script_execute(callback, value)
			}
		}

		if check_menu_return {
			if script_exists(entry_upper.back_delegate)
				script_execute(entry_upper.back_delegate, id)
		}
	}
}
