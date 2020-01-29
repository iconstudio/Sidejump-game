/// @description 메뉴 항목 열거
draw_set_font(fontMenu)
with menu_add_entry_caption("Campaign") {
	menu_add_other(oMenuEntryCampaign, id)
	menu_add_entry_caption("Back", callback_menu_back)
}

with menu_add_entry_caption("Endless") {
	menu_add_entry_caption("Back", callback_menu_back)
}

with menu_add_entry_caption("Setting") {
	with menu_add_entry_caption("BGM Volume: ") {
		menu_add_entry_caption("10")
		menu_add_entry_caption("Back", callback_menu_back)
	}
	with menu_add_entry_caption("SFX Volume: ") {
		menu_add_entry_caption("10")
		menu_add_entry_caption("Back", callback_menu_back)
	}
	with menu_add_entry_caption("Fullscreen: ") {
		menu_add_entry_caption("On")
		menu_add_entry_caption("Back", callback_menu_back)
	}

	with menu_add_entry_caption("Keyboard Controls") {
		menu_add_entry_caption("Back", callback_menu_back)
	}
	if gamepad_is_supported() {
		with menu_add_entry_caption("Gamepad Controls") {
			menu_add_entry_caption("Back", callback_menu_back)
		}
	}

	with menu_add_entry_caption("Graphics: ") {
		menu_add_entry_caption("High")
		menu_add_entry_caption("Medium")
		menu_add_entry_caption("Low")
		menu_add_entry_caption("Back", callback_menu_back)
	}

	menu_add_entry_caption("Back", callback_menu_back)
}

with menu_add_entry_caption("Credit") {
	menu_add_entry_caption("Content")
	menu_add_entry_caption("Back", callback_menu_back)
}

menu_add_entry_caption("Exit", callback_menu_exit)

menu_choice(entry_choice_index)
