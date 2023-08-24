/// @description menu_entry_open(entry)
/// @function menu_entry_open
/// @param entry { instance }
function menu_entry_open(argument0) {
	with argument0 {
		if !opened {
			menu_entry_execute(id)
			if openable and 0 < ds_list_size(entry_list) {
				opened = true
				menu_choice(entry_choice_index)
				with oMainMenu
					entry_current_opened = other.id
				menu_push()
			}
		}
	}



}
