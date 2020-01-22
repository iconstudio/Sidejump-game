/// @description menu_add(caption, [callback])
/// @function menu_add
/// @param index { instance }
/// @param caption { string }
/// @param [callback] { script }
var menu_callback = argument_count > 1 ? argument[1] : -1
var menu_item = instance_create_layer(0, 0, layer, oMainMenuEntry)
ds_list_add(entry_list, menu_item)

return menu_add_other(id, argument[0], menu_callback)
