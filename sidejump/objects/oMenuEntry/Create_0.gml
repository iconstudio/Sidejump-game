/// @description 메뉴 항목 초기화
entry_list = ds_list_create()
entry_choice = noone
entry_choice_index = 0
entry_upper = noone // 상위 메뉴 항목

callback = -1
opened = false
open_time = 0
open_period = seconds(0.3)

custom_x = -1
custom_y = -1
