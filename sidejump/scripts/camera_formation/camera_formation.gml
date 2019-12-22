/// @description camera_formation(formation)
/// @function camera_formation
/// @param formation { enumerate }
with oGameGlobal {
	if camera.mode != argument0 {
		camera.mode = argument0
		camerawork_time = 0
		camerawork_coordinate_begin = [camera.x, camera.y]
		camerawork_status = MOVING
	}
}
