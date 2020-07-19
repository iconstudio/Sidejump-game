/// @description menu_button_place_at_bottom(menu)
/// @function menu_button_place_at_bottom
/// @param menu { instance }
function menu_button_place_at_bottom(argument0) {
	with argument0 {
		use_custom_coords = true
		custom_y = global.resolutions_gui[1] - height - 4
	}


}
