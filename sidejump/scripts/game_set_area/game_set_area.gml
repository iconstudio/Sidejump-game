/// @description game_set_area(area)
/// @function game_set_area
/// @param area { instance }
with oGameCamera {
	if global.game_area != argument0 {
		area_previous = global.game_area
		global.game_area = argument0
		camera_set_mode(camera_mode.transition)
		camerawork_time = 0
		camerawork_coordinate_begin = [x, y]
		camerawork_status = MOVING
	}
}
