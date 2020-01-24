/// @description callback_menu_back()
/// @function callback_menu_back
with entry_upper {
	oMainMenu.entry_current_opened = entry_upper.id
	with oMainMenu {
		var push = menu_get_y_last()
		menu_drawn_y_target = menu_drawn_y_default - push[0]
		menu_drawn_y_begin = menu_drawn_y
		menu_drawn_y_time = 0
		entry_last = other.id
	}
	opened = false // 주의: 주 메뉴에서 절대 실행시키지 말 것
}
