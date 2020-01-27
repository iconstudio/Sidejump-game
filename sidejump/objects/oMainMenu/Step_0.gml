/// @description 갱신
switch scene {
	case TITLE_APPEAR:
	var appear_ratio = appear_time / appear_period
	image_alpha = ease_out_quartic(appear_ratio)
	image_xscale = 1 + ease_in_out_back(1 - appear_ratio) * 0.3
	if appear_time < appear_period {
		appear_time++
	} else {
		appear_time = 0
		image_alpha = 1
		image_xscale = 1
		scene = TITLE_IDLE
	}
	image_yscale = image_xscale
	break

	case TITLE_IDLE:
	if idle_await_time < idle_await_period {
		idle_await_time++
	} else {
		if global.io_pressed_exit {
			scene = TITLE_EXIT
		} else {
			var condition0 = keyboard_check_pressed(vk_anykey)
			var condition1 = mouse_check_button_pressed(mb_left) and !global.flag_is_desktop
			var condition2 = oGamepad.index != -1
			if condition0 or condition1 or condition2 {
				idle_await_time = 0
				menu_appear_time = 0
				scene = MAIN_ENTER
			}
		}
	}
	break

	case MAIN_ENTER:
	var disappear_ratio = disappear_time / disappear_period
	image_alpha = 1 - ease_out_quad(disappear_ratio)
	y = lerp(title_y, title_disappear_y, ease_in_cubic(disappear_ratio))

	if disappear_time < disappear_period {
		disappear_time++
	} else {
		disappear_time = 0
		image_alpha = 0
		scene = MAIN_IDLE
	}

	main_alpha = ease_out_quad(menu_appear_time / menu_appear_period)
	if menu_appear_time < menu_appear_period
		menu_appear_time++
	else
		menu_appear_time = menu_appear_period
	break

	case MAIN_IDLE:
	main_alpha = ease_out_quad(menu_appear_time / menu_appear_period)
	if menu_appear_time < menu_appear_period {
		menu_appear_time++
	} else if input_delay_time < input_delay_period {
		input_delay_time++
	} else if !lock {
		menu_appear_time = menu_appear_period

		if global.io_pressed_exit {
			if entry_current_opened == id {
				scene = MAIN_BACK_TO_TITLE
			} else {
				with entry_current_opened {
					
				}
			}
		} else {
			var check_menu_up = global.io_pressed_up
			var check_menu_dw = global.io_pressed_down
			var check_menu_go = global.io_pressed_yes

			if check_menu_up xor check_menu_dw {
				with entry_current_opened {
					if check_menu_up
						menu_select(entry_choice_index - 1)
					else if check_menu_dw
						menu_select(entry_choice_index + 1)
				}
			}

			if check_menu_go {
				menu_entry_open(entry_last)
				input_delay_time = 0
			} // IF (check_menu_go)
		}
	}

	if menu_drawn_y_time < menu_drawn_y_period {
		var drawn_interpolation_ratio = menu_drawn_y_time / menu_drawn_y_period
		menu_drawn_y = lerp(menu_drawn_y_begin, menu_drawn_y_target, ease_in_out_cubic(drawn_interpolation_ratio))
		menu_drawn_y_time++
	} else {
		menu_drawn_y = menu_drawn_y_target
	}
	break

	case MAIN_BACK_TO_TITLE:
	var reappear_ratio = reappear_time / reappear_period
	image_alpha = 0.5 + ease_out_quad(reappear_ratio) // *
	y = lerp(title_disappear_y, title_y, ease_in_cubic(reappear_ratio))
	main_alpha = 1 - ease_out_expo(reappear_ratio)

	if reappear_time < reappear_period {
		reappear_time++
	} else {
		reappear_time = 0
		image_alpha = 1
		scene = TITLE_IDLE
	}
	break

	case TITLE_EXIT:
	var exit_ratio = exit_time / exit_period
	image_alpha = 1 - ease_out_expo(exit_ratio)
	y = lerp(title_y, title_disappear_y, ease_out_circ(exit_ratio))
	image_yscale = image_xscale
	if exit_time < exit_period
		exit_time++
	else
		game_end()
	break

	case MAIN_EXIT:
	var exit_ratio = exit_time / exit_period
	y = lerp(title_y, title_disappear_y, ease_out_circ(exit_ratio))
	if exit_time < exit_period
		exit_time++
	else
		game_end()
	break

	default:
		
	break
}

switch bg_scene {
	case SHOW:
	break

	case OPENING:
	break

	case FADEOUT:
	break
}

if menu_drawn_y_push != 0
	menu_drawn_y_push -= menu_drawn_y_push * 0.1
