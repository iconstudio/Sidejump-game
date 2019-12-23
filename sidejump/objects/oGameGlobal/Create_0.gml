/// @description 초기화
enum camera_mode {
	dynamic,
	fixed,
	cutscene,
	transition_horizontal,
	transition_vertical
}

enum camera_position {
	left_up,
	left_middle,
	left_down,
	center_up,
	center_middle,
	center_down,
	right_up,
	right_middle,
	right_down
}

enum camera_transition {
	left,
	up,
	right,
	down,
}

camera = instance_create_layer(0, 0, layer, oCamera)
END = 0
MOVING = 1
CLEARING = 2
camerawork_status = END
camerawork_coordinate_begin = [0, 0]
camerawork_coordinate_target = [0, 0]
camerawork_period = seconds(0.9)
camerawork_time = camerawork_period
camerawork_transition_horizontal_velocity = camera.width / camerawork_period
camerawork_transition_vertical_velocity = camera.height / camerawork_period

camera_set_mode(camera_mode.dynamic)
camera_set_formation(camera_position.left_up)
camerawork_time = camerawork_period
