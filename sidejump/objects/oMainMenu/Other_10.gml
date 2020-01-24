/// @description 메뉴 항목 열거
draw_set_font(fontMenuMedium)
with menu_add_entry_caption("Campaign") {
	menu_add_entry_caption("Cleft Moor") // 갈라진 습지
	menu_add_entry_caption("Cave of Grief") // 통곡의 동굴
	menu_add_entry_caption("Volcano") // 화산
	menu_add_entry_caption("Red Forest") // 붉은 숲
	menu_add_entry_caption("Coast") // 해안
	menu_add_entry_caption("Tearing City") // 찢어지는 도시
	menu_add_entry_caption("Factory of Doom") // 파멸의 공장
	menu_add_entry_caption("Skyrocket") // 고공 상승
	menu_add_entry_caption("Back", callback_menu_back)
}

with menu_add_entry_caption("Endless") {
	menu_add_entry_caption("Back", callback_menu_back)
}

with menu_add_entry_caption("Setting") {
	with menu_add_entry_caption("BGM: ") {
		menu_add_entry_caption("Back", callback_menu_back)
	}
	with menu_add_entry_caption("SFX: ") {
		menu_add_entry_caption("Back", callback_menu_back)
	}
	menu_add_entry_caption("Fullscreen: ")
	menu_add_entry_caption("Resolution: ")
	menu_add_entry_caption("Graphics: ")
	menu_add_entry_caption("Back", callback_menu_back)
}

with menu_add_entry_caption("Credit") {
	menu_add_entry_caption("Back", callback_menu_back)
}

menu_add_entry_caption("Exit", callback_menu_exit)

menu_choice(entry_choice_index)
