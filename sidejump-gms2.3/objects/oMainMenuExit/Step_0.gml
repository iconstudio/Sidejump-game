/// @description 투명도 갱신
if !deadend {
	image_alpha = lerp(0, alpha_target, ease_out_cubic(alpha_time / alpha_period))

	if alpha_time < alpha_period {
		alpha_time++
	} else {
		alpha_time = alpha_period
	}

	text_alpha = ease_in_out_elastic(text_alpha_time / text_alpha_period)
	if text_alpha_time < text_alpha_period {
		text_alpha_time++
	} else {
		text_alpha_time = text_alpha_period
		
		var check_menu_up = global.io_pressed_left or global.io_pressed_up
		var check_menu_dw = global.io_pressed_right or global.io_pressed_down
		var check_menu_go = global.io_pressed_yes

		if check_menu_up ^^ check_menu_dw {
			if check_menu_up or check_menu_dw
				selection = !selection
		}

		if check_menu_go {
			deadend = true
			if selection == 1
				fadeout = true
		}
	}
}

if deadend {
	image_alpha = lerp(alpha_target, 0, (fadeout_time / fadeout_period))
	text_alpha = 1 - ease_in_cubic(alpha_time / alpha_period)

	if textout_time < textout_period {
		textout_time++
	} else {
		textout_time = textout_period
		if selection == 0 {
			with oMainMenu
				scene = MAIN_EXIT
		} else {
			with oMainMenu
				lock = false
			instance_destroy()
		}
	}

	if fadeout {
		if fadeout_time < fadeout_period {
			fadeout_time++
		} else {
			fadeout_time = fadeout_period
		}
	}
}

if alpha_shroud_fall {
	alpha_shroud_speed += alpha_shroud_gravity
	alpha_shroud_y += alpha_shroud_speed
	if global.resolutions_gui[1] <= alpha_shroud_y {
		alpha_shroud_speed *= -0.7
		if abs(alpha_shroud_speed) < alpha_shroud_speed_min {
			alpha_shroud_y = global.resolutions_gui[1]
			alpha_shroud_speed = 0
			alpha_shroud_fall = false
		}
	}
}
