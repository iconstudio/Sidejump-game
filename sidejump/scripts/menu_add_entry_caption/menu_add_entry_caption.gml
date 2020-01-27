/// @description menu_add_entry_caption(caption, [callback], [predicate])
/// @function menu_add_entry_caption
/// @param caption { string }
/// @param [callback] { script }
/// @param [predicate] { script }
var menu_callback = 1 < argument_count ? argument[1] : -1
var menu_variable = 2 < argument_count ? argument[2] : ""
with menu_add_other(oMenuEntryCaption, id, menu_callback) {
	caption = argument[0]
	info_predicate = menu_variable
	width = string_width(caption)
	height_min = string_height(caption) + oMainMenu.menu_entry_height_padding
	height_max = height_min * oMainMenu.menu_entry_font_scale
	height = height_min
	return id
}
