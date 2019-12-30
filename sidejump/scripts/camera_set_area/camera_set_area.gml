/// @description camera_set_area(area)
/// @function camera_set_area
/// @param area { instance }
with oCamera {
	if area != argument0 {
		area = argument0
		camera_set_mode(camera_mode.transition_area)
		camerawork_time = 0
		camerawork_coordinate_begin = [x, y]
		camerawork_status = MOVING
	}
}
