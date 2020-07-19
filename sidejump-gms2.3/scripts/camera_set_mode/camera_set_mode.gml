/// @description camera_set_mode(mode)
/// @function camera_set_mode
/// @param mode { enumerate }
function camera_set_mode(argument0) {
	with oGameCamera {
		if mode != argument0 {
			mode = argument0
			camerawork_time = 0
			camerawork_coordinate_begin = [x, y]
			camerawork_status = MOVING
		}
	}



}
