for (var i = 0; i < menu_items_number; ++i) {
	if ds_exists(menu_items, ds_type_list)
		ds_list_destroy(menu_items[i])
}

menu_items = 0
menu_item_selected = 0
