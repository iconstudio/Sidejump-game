/// @description camera_formation(formation)
/// @function camera_formation
/// @param formation { enumerate }
with oGameGlobal {
	if camera.postition != argument0 {
		camera.postition = argument0
		camerawork_time = 0
		camerawork_coordinate_begin = [camera.x, camera.y]
		camerawork_status = MOVING
	}
}
