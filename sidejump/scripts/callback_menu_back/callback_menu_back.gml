/// @description callback_menu_back()
/// @function callback_menu_back
with entry_upper {
	oMainMenu.entry_current_opened = entry_upper.id
	oMainMenu.entry_last = id

	menu_push()
	opened = false // 주의: 주 메뉴에서 절대 실행시키지 말 것
}
