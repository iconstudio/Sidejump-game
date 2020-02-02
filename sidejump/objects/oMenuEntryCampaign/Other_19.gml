/// @description 정리
chapter_board_await_time = 0
if 0 < chapter_board_number {
	for (var i = 0; i < chapter_board_number; ++i) {
		with menu_get_entry(i)
			event_user(3)
	}
	//menu_choice(0)
}
scale = 0
chapter_board_scroll = 0
