/// @description game_set_area(area)
/// @function game_set_area
/// @param area { instance }
function game_set_area(argument0) {
	with oGameCamera {
		if global.game_area != argument0 {
			area_previous = global.game_area
			global.game_area = argument0
			if global.game_area.bbox_right - global.game_area.bbox_left < 240
				area_is_small = true
			else if global.game_area.bbox_bottom - global.game_area.bbox_top < 120
				area_is_small = true
			else
				area_is_small = false

			if area_is_small {
				show_debug_message("\nSmall Area: " + string(global.game_area.id) + " (" + string(global.game_area.x) + ")")
				show_debug_message("\nPrevious Area: " + string(area_previous.id) + " (" + string(area_previous.x) + ")")
			}
		
			game_area_activate(argument0)
			camera_set_mode(camera_mode.transition)
			camerawork_time = 0
			camerawork_coordinate_begin = [x, y]
			camerawork_status = MOVING
		}
	}



}
