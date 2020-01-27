
/// @description menu_add_other(type, target, [callback])
/// @function menu_add_other
/// @param type { object }
/// @param target { instance }
/// @param [callback] { script }
var menu_depth = argument[1]
var menu_callback = 2 < argument_count ? argument[2] : -1
var menu_item = instance_create_layer(0, 0, "Menu", argument[0])
with menu_item {
	callback = menu_callback
	entry_upper = menu_depth.id

	//event_perform(ev_create, 0)
	//instance_change(argument[0], false)
	//event_perform(ev_create, 0)

	ds_list_add(menu_depth.entry_list, id)
	return id
}
