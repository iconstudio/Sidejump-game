/// @description 메뉴 항목 열거
draw_set_font(fontMenuMedium)
with menu_add_entry_caption("Campaign") {
	menu_add_other(oMenuEntryCampaign, id)
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
