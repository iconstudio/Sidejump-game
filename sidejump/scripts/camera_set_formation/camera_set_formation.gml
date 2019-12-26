/// @description camera_set_formation(formation)
/// @function camera_set_formation
/// @param formation { enumerate }
with oCamera {
	if postition != argument0 {
		postition = argument0
		camerawork_time = 0
		camerawork_coordinate_begin = [x, y]
		camerawork_status = MOVING
	}
}
