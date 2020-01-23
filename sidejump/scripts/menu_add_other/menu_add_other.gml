/// @description menu_add_other(type, target, [callback])
/// @function menu_add_other
/// @param type { object }
/// @param target { instance }
/// @param [callback] { script }
var menu_depth = argument[1]
var menu_callback = 2 < argument_count ? argument[2] : -1
var menu_item = instance_create_layer(0, 0, layer, argument[0])
with menu_depth
	ds_list_add(entry_list, menu_item)

with menu_item {
	callback = menu_callback
	entry_upper = menu_depth.id

	return id
}
