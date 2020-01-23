/// @description menu_add_entry_caption(caption, [callback])
/// @function menu_add_entry_caption
/// @param caption { string }
/// @param [callback] { script }
var menu_callback = 1 < argument_count ? argument[1] : -1
with menu_add_other(oMainMenuEntryCaption, id, menu_callback) {
	caption = argument[0]
	width = string_width(caption)
	height = string_height(caption) + oMainMenu.menu_entry_height_border
	return id
}
