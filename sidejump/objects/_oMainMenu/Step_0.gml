/// @description 메뉴 갱신
cursor_x = device_mouse_x(0)
cursor_y = device_mouse_y(0)
cursor_gui_x_previous = cursor_gui_x
cursor_gui_y_previous = cursor_gui_y
cursor_gui_x = device_mouse_x_to_gui(0)
cursor_gui_y = device_mouse_y_to_gui(0)
if cursor_gui_x == cursor_gui_x_previous {
	cursor_fast_count = 0
} else {
	var cursor_gap = point_distance(cursor_gui_x, cursor_gui_y, cursor_gui_x_previous, cursor_gui_y_previous)
	if cursor_gap < 16
		cursor_fast_count = 0
	else
		cursor_fast_count++
}

var cursor_left = device_mouse_check_button(0, mb_left)
var cursor_right = device_mouse_check_button(0, mb_right)
var cursor_left_pressed = device_mouse_check_button_pressed(0, mb_left)
var cursor_right_pressed = device_mouse_check_button_pressed(0, mb_right)
var cursor_left_released = device_mouse_check_button_released(0, mb_left)
var key_left = keyboard_check(vk_left)
var key_right = keyboard_check(vk_right)
var key_left_pressed = keyboard_check_pressed(vk_left)
var key_up_pressed = keyboard_check_pressed(vk_up)
var key_right_pressed = keyboard_check_pressed(vk_right)
var key_down_pressed = keyboard_check_pressed(vk_down)

if menu_mode != NONE {
	

	exit
}

if menu_pushing {
	menu_scroll = lerp(menu_scroll_begin, menu_scroll_target, script_execute(menu_scroll_easer, menu_push_time / menu_push_period))

	if menu_push_time < menu_push_period {
		menu_push_time++
	} else {
		// 메뉴 이동 주기 초기화
		if menu_pushing and menu_push_period != menu_push_period_max
			menu_push_period = menu_push_period_max
		menu_pushing = false

		menu_push_time = menu_push_period
	}
} else {
	// 드래그 중
	if menu_dragging and cursor_left {
		if menu_drag_mover_coord_begin[0] != -1 and menu_drag_mover_coord_begin[1] != -1 {
			menu_scroll = median(menu_index == 0 ? menu_scroll_target - menu_drag_lesseraway : menu_scroll_target - menu_drag_faraway
			, menu_drag_begin[0] - (cursor_gui_x - menu_drag_mover_coord_begin[0])
			, menu_index == menu_number - 1 ? menu_scroll_target + menu_drag_lesseraway : menu_scroll_target + menu_drag_faraway)

			menu_scroll_vertical = menu_drag_begin[1] + (cursor_gui_y - menu_drag_mover_coord_begin[1])
		}
	}

	// 드래그 시작
	if !menu_dragging {
		if cursor_left_pressed {
			menu_drag_begin = [menu_scroll, menu_scroll_vertical]
			menu_drag_mover_coord_begin = [cursor_x, cursor_y]

			menu_dragging = true
		}
	}

	var menu_choice = -1
	// 드래그 끝: 메뉴 전환과 정위치
	if menu_dragging and cursor_left_released {
		menu_dragging = false

		menu_drag_mover_coord_begin = [-1, -1]

		if menu_drag_threshold_vertical <= abs(menu_scroll_vertical) {
			// 상하로 메뉴 전환
			if 0 < menu_scroll_vertical { // 위쪽
				menu_choice = UP
			} else { // 아래쪽
				menu_choice = DOWN
			}
		} else {
			var scroll_horizontal_gap = menu_scroll_target - menu_scroll
			if cursor_fast_threshold <= cursor_fast_count {
				// 일정 빠르기 이상이면 메뉴 전환
				if 0 < scroll_horizontal_gap { // 왼쪽
					menu_choice = LEFT
				} else { // 오른쪽
					menu_choice = RIGHT
				}
			} else if menu_drag_threshold <= abs(scroll_horizontal_gap) {
				// 일정 거리 이상 옮기면 메뉴 전환
				if 0 < scroll_horizontal_gap { // 왼쪽
					menu_choice = LEFT
				} else { // 오른쪽
					menu_choice = RIGHT
				}
			} else {
				// 원래 위치로 되돌아가기
				menu_transition(menu_index)
			}
		}
		menu_scroll_vertical = 0
	}

	// 스크롤 부드럽게
	//if menu_dragging {
	//	if menu_scroll != menu_scroll_pre or menu_scroll_vertical != menu_scroll_vertical_pre {
	//		menu_scroll += (menu_scroll_pre - menu_scroll) * 0.6
	//		menu_scroll_vertical += (menu_scroll_vertical_pre - menu_scroll_vertical) * 0.6
	//	}
	//}

	// 키를 통한 메뉴 전환
	if !menu_dragging and !menu_pushing {
		if key_left_pressed xor key_right_pressed {
			if key_left_pressed {
				if 0 < menu_index {
					menu_choice = LEFT
				}
			} else if key_right_pressed {
				if menu_index < menu_number - 1 {
					menu_choice = RIGHT
				}
			}
		}
	}

	// 메뉴 실행
	if menu_choice != -1 {
		var submenu_number = ds_list_size(menu_items[menu_index])
		if 0 < submenu_number {
			for (var i = 0; i < submenu_number; ++i) {
				var menu_item = ds_list_find_value(menu_items[menu_index], i)
				if !instance_exists(menu_item)
					show_error("메뉴 항목을 생성할 때 문제가 발생했습니다.", true)

				if menu_item.position == menu_choice and script_exists(menu_item.callback) {
					menu_item_selected[menu_number] = i
					script_execute(menu_item.callback, menu_item)
					break
				}
			}
		}
	}
}
