/// @description 카메라 이동
if !instance_exists(camera.target)
	exit

switch camera.mode {
	case camera_mode.left_up:
		camerawork_coordinate_target[0] = camera.target.x - global.resolutions_default[0] * 0.5 - camera.border
		camerawork_coordinate_target[1] = camera.target.y - global.resolutions_default[1] * 0.5 - camera.border
	break

	case camera_mode.left_middle:
		camerawork_coordinate_target[0] = camera.target.x - global.resolutions_default[0] * 0.5 - camera.border
		camerawork_coordinate_target[1] = camera.target.y
	break

	case camera_mode.left_down:
		camerawork_coordinate_target[0] = camera.target.x - global.resolutions_default[0] * 0.5 - camera.border
		camerawork_coordinate_target[1] = camera.target.y + global.resolutions_default[1] * 0.5 - camera.border
	break

	case camera_mode.center_up:
		camerawork_coordinate_target[0] = camera.target.x
		camerawork_coordinate_target[1] = camera.target.y - global.resolutions_default[1] * 0.5 - camera.border
	break

	case camera_mode.center_middle:
		camerawork_coordinate_target[0] = camera.target.x
		camerawork_coordinate_target[1] = camera.target.y
	break

	case camera_mode.center_down:
		camerawork_coordinate_target[0] = camera.target.x
		camerawork_coordinate_target[1] = camera.target.y + global.resolutions_default[1] * 0.5 + camera.border
	break

	case camera_mode.right_up:
		camerawork_coordinate_target[0] = camera.target.x + global.resolutions_default[0] * 0.5 + camera.border
		camerawork_coordinate_target[1] = camera.target.y - global.resolutions_default[1] * 0.5 - camera.border
	break

	case camera_mode.right_middle:
		camerawork_coordinate_target[0] = camera.target.x + global.resolutions_default[0] * 0.5 + camera.border
		camerawork_coordinate_target[1] = camera.target.y
	break

	case camera_mode.right_down:
		camerawork_coordinate_target[0] = camera.target.x + global.resolutions_default[0] * 0.5 + camera.border
		camerawork_coordinate_target[1] = camera.target.y + global.resolutions_default[1] * 0.5 + camera.border
	break

	default:
	break
}

if camerawork_time < camerawork_period {
	var camerawork_ratio = camerawork_time / camerawork_period
	camera.x = lerp(camerawork_coordinate_begin[0], camerawork_coordinate_target[0], camerawork_ratio)
	camera.y = lerp(camerawork_coordinate_begin[1], camerawork_coordinate_target[1], camerawork_ratio)

	camerawork_time++

	if camerawork_period <= camerawork_time
		camerawork_status = CLEARING
} else {
	if camerawork_status == CLEARING {
		camerawork_time = camerawork_period
		camera.x = camerawork_coordinate_target[0]
		camera.y = camerawork_coordinate_target[1]
		camerawork_status = END
	} else {
		with camera
			mp_linear_step_object(other.camerawork_coordinate_target[0], other.camerawork_coordinate_target[1], 4, oCameraBlock)
	}
}
