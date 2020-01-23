/// @description 초기화
global.io_left = false
global.io_right = false
global.io_up = false
global.io_down = false
global.io_hang = false
global.io_pressed_left = false
global.io_pressed_right = false
global.io_pressed_up = false
global.io_pressed_down = false
global.io_pressed_jump = false
global.io_pressed_dash = false
global.io_released_jump = false
global.io_released_hang = false

global.io_pressed_yes = false
global.io_pressed_no = false
global.io_pressed_exit = false

event_user(1)

network_update_period = seconds(3)
alarm[0] = network_update_period
