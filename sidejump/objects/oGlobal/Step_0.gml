/// @description 입력 처리
global.io_left = keyboard_check(vk_left)
global.io_right = keyboard_check(vk_right)
global.io_up = keyboard_check(vk_up)
global.io_down = keyboard_check(vk_down)
global.io_hang = keyboard_check(ord("Z"))

global.io_pressed_left = keyboard_check_pressed(vk_left)
global.io_pressed_right = keyboard_check_pressed(vk_right)
global.io_pressed_up = keyboard_check_pressed(vk_up)
global.io_pressed_down = keyboard_check_pressed(vk_down)
global.io_pressed_jump = keyboard_check_pressed(vk_space) or keyboard_check_pressed(ord("X"))
global.io_pressed_dash = keyboard_check_pressed(ord("C"))
global.io_released_hang = keyboard_check_pressed(ord("Z"))

global.io_released_jump = keyboard_check_released(vk_space) or keyboard_check_released(ord("X"))
global.io_pressed_yes = global.io_pressed_jump or keyboard_check_pressed(vk_enter)
global.io_pressed_no = global.io_pressed_dash
global.io_pressed_exit = keyboard_check_pressed(vk_escape) or keyboard_check_pressed(vk_backspace)
