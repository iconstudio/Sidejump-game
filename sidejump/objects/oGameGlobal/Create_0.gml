/// @description 초기화
enum camera_mode {
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
var camera_current = camera_get_active()
image_xscale = camera_get_view_width(camera_current)
image_yscale = camera_get_view_height(camera_current)
camerawork_coordinate_begin = [0, 0]
camerawork_coordinate_target = [0, 0]
camera_formation(camera_mode.left_up)
camerawork_period = seconds(0.8)
camerawork_time = camerawork_period
END = 0
MOVING = 1
CLEARING = 2
camerawork_status = END
