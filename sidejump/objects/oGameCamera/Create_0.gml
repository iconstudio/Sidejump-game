area_previous = noone
area_is_small = false
mode = camera_mode.follow
target = oPlayer

width = 480
height = 240
anchor_x = 0.5
anchor_y = 0.5
origin_x = 0
origin_y = 0
image_xscale = width * 0.125
image_yscale = height * 0.125

dest_x = x
dest_y = y
center_x = anchor_x * width
center_y = anchor_y * height
left_x = width - center_x
left_y = height - center_y
border = 24 // 16 + 8

NORMAL = 0
MOVING = 1
CLEARING = 2
camerawork_status = CLEARING
camerawork_coordinate_begin = [0, 0]
camerawork_coordinate_target = [0, 0]
camerawork_transition_period = seconds(0.9)
camerawork_period = seconds(0.9)
camerawork_time = camerawork_period
