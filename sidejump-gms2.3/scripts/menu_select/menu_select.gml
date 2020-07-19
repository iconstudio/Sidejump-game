/// @description menu_select(index)
/// @function menu_select
/// @param index { integer }
function menu_select(argument0) {
	var size = ds_list_size(entry_list)

	if argument0 < 0
		argument0 += size
	else if size - 1 < argument0
		argument0 -= size

	menu_choice(argument0)



}
