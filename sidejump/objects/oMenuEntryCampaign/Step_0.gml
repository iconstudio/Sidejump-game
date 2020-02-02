/// @description 챕터 보드 갱신
event_inherited()

scale = entry_upper.open_time / entry_upper.open_period
board_height = height - board_margin * 2
if scale < 1 {
	var opening_ratio = scale
	height = lerp(0, height_max, ease_in_expo(opening_ratio))
	if entry_upper.opened {
		board_y_half = board_y_half_max
	} else {
		board_y_half = board_y + board_height * 0.5

		if closing_time < closing_period
			closing_time++
		else
			closing_time = closing_period

		if entry_upper.open_time == 0 // 닫힌 상태
			event_user(9)
	}
} else {

	if chapter_board_await_time < chapter_board_await_period {
		chapter_board_await_time++
	} else if entry_upper.opened and entry_upper.entry_choice == id
	and !instance_exists(oMenuCampaignPopup) and scale == 1 and !lock {
		var check_menu_lf = global.io_pressed_left
		var check_menu_rt = global.io_pressed_right
		var check_menu_go = global.io_pressed_yes
		
		if check_menu_lf xor check_menu_rt {
			if check_menu_lf {
				if 0 < entry_choice_index
					menu_choice(entry_choice_index - 1)
			} else if check_menu_rt {
				if entry_choice_index < chapter_board_number - 1
					menu_choice(entry_choice_index + 1)
			}
		}

		if check_menu_go {
			menu_choice(entry_choice_index)
			menu_entry_open(oMainMenu.entry_last)
		}
	}
	chapter_board_scroll = -entry_choice_index * chapter_board_each_gap
}
