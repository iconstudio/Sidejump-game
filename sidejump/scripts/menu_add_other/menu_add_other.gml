/// @description menu_add_other(index, caption, [callback])
/// @function menu_add_other
/// @param index { instance }
/// @param caption { string }
/// @param [callback] { script }
var menu_depth = argument[0]
var menu_callback = 2 < argument_count ? argument[2] : -1
var menu_item = instance_create_layer(0, 0, layer, oMainMenuEntry)
with menu_depth
	ds_list_add(entry_list, menu_item)

with menu_item {
	caption = argument[1]
	callback = menu_callback
	width = string_width(caption)
	height = string_height(caption) + oMainMenu.menu_entry_height_border
	entry_upper = menu_depth

	return id
}
