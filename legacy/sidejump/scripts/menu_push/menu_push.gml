/// @description menu_push()
/// @function menu_push
with oMainMenu {
	var push = menu_get_y_last()
	menu_drawn_y_target = menu_drawn_y_default - push[0]
	menu_drawn_y_begin = menu_drawn_y
	menu_drawn_y_time = 0
}
