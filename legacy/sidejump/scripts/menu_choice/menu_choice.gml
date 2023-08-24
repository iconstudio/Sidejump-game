/// @description menu_choice(index)
/// @function menu_choice
/// @param index { integer }
entry_choice_index = argument0
entry_choice = menu_get_entry(entry_choice_index)
oMainMenu.entry_last = entry_choice
