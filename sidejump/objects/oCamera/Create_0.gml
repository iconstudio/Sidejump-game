area = noone
area_previous = noone
mode = camera_mode.dynamic
postition = camera_position.center_middle
target = oPlayer

width = 480
height = 240
anchor_x = 0.5
anchor_y = 0.5
origin_x = 0
origin_y = 0
image_xscale = width * 0.125
image_yscale = height * 0.125
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
camerawork_transition_direction = [0, 0]
camerawork_transition_horizontal_velocity = floor(width / camerawork_period)
