/// @description controls_clear()
/// @function controls_clear
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
global.io_pressed_talk = false
global.io_pressed_exit = false
global.io_pressed_yes = false
global.io_pressed_no = false

global.io_released_hang = false
global.io_released_jump = false

ds_map_clear(global.controls_keyboard)
var temp_list = ds_list_create()
// 
ds_list_add(temp_list, vk_left)
ds_list_add(temp_list, vk_numpad4)
ds_map_add_list(global.controls_keyboard, "left", temp_list)
ds_list_clear(temp_list)
// 
ds_list_add(temp_list, vk_up)
ds_list_add(temp_list, vk_numpad8)
ds_map_add_list(global.controls_keyboard, "up", temp_list)
ds_list_clear(temp_list)
// 
ds_list_add(temp_list, vk_right)
ds_list_add(temp_list, vk_numpad6)
ds_map_add_list(global.controls_keyboard, "right", temp_list)
ds_list_clear(temp_list)
// 
ds_list_add(temp_list, vk_down)
ds_list_add(temp_list, vk_numpad5)
ds_list_add(temp_list, vk_numpad2)
ds_map_add_list(global.controls_keyboard, "down", temp_list)
ds_list_clear(temp_list)
// 
ds_list_add(temp_list, ord("Z"))
ds_list_add(temp_list, vk_shift)
ds_map_add_list(global.controls_keyboard, "hang", temp_list)
ds_list_clear(temp_list)
// 
ds_list_add(temp_list, ord("X"))
ds_list_add(temp_list, vk_space)
ds_map_add_list(global.controls_keyboard, "jump", temp_list)
ds_list_clear(temp_list)
// 
ds_list_add(temp_list, ord("C"))
ds_list_add(temp_list, vk_alt)
ds_map_add_list(global.controls_keyboard, "dash", temp_list)
ds_list_clear(temp_list)
// 
ds_list_add(temp_list, ord("V"))
ds_list_add(temp_list, vk_control)
ds_map_add_list(global.controls_keyboard, "talk", temp_list)
ds_list_clear(temp_list)

// 
ds_list_add(temp_list, vk_backspace)
ds_list_add(temp_list, vk_escape)
ds_map_add_list(global.controls_keyboard, "exit", temp_list)
ds_list_clear(temp_list)

// *
ds_list_add(temp_list, vk_enter)
ds_list_add(temp_list, vk_space)
ds_map_add_list(global.controls_keyboard, "yes", temp_list)
ds_list_clear(temp_list)
// *
ds_list_add(temp_list, vk_backspace)
ds_list_add(temp_list, vk_escape)
ds_map_add_list(global.controls_keyboard, "no", temp_list)
ds_list_clear(temp_list)

ds_map_clear(global.controls_gamepad)

ds_list_destroy(temp_list)
