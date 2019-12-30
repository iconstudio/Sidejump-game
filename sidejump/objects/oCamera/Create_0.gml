area = noone
mode = camera_mode.dynamic
postition = camera_position.center_middle
target = oPlayer

width = 480
height = 240
image_xscale = width * 0.125
image_yscale = height * 0.125
border = 24 // 16 + 8

END = 0
MOVING = 1
CLEARING = 2
camerawork_status = END
camerawork_coordinate_begin = [0, 0]
camerawork_coordinate_target = [0, 0]
camerawork_period = seconds(0.9)
camerawork_time = camerawork_period
camerawork_transition_direction = [0, 0]
camerawork_transition_horizontal_velocity = floor(width / camerawork_period)
