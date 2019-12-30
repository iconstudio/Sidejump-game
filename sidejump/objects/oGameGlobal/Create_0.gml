/// @description 초기화
enum camera_mode {
	dynamic,
	fixed,
	cutscene,
	transition_area
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

camera = instance_create_layer(0, 0, layer, oCamera)
