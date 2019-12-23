/// @description camera_set_mode(mode)
/// @function camera_set_mode
/// @param mode { enumerate }
with oGameGlobal {
	if camera.mode != argument0 {
		camera.mode = argument0
		camerawork_time = 0
		camerawork_coordinate_begin = [camera.x, camera.y]
		camerawork_status = MOVING
	}
}
