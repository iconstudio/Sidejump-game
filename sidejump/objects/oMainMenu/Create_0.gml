/// @description 메뉴 초기화
// 메뉴 장면
TITLE_APPEAR = 0
TITLE_IDLE = 1
MAIN_ENTER = 2
MAIN_IDLE = 4
MAIN_BACK_TO_TITLE = 20
TITLE_EXIT = 90
MAIN_EXIT = 91

appear_time = 0 
appear_period = seconds(0.9)
idle_await_time = 0
idle_await_period = seconds(0.6)
disappear_time = 0 
disappear_period = seconds(0.4)
title_y = room_height * 0.5
title_disappear_y = title_y - 60
x = room_width * 0.5
y = room_height * 0.5
image_alpha = 0
image_xscale = 0
image_yscale = 0
main_alpha = 0
menu_appear_time = 0 
menu_appear_period = seconds(0.7)
exit_time = 0 
exit_period = seconds(0.4)
scene = MAIN_IDLE

// 메뉴 그리기 속성
menu_drawn_x_begin = floor(global.resolutions_gui[0] * 0.15)
menu_drawn_y_begin = floor(global.resolutions_gui[0] * 0.05)

menu_entry_width_addition = 12
menu_entry_height_border = 4

// 메뉴 항목
opened = true // 주 메뉴는 무조건 true지만 디버그 용으로 남겨둔다.
entry_last = noone // 종류를 막론하고 마지막으로 선택된 메뉴 항목
entry_list = ds_list_create()
entry_choice_current = id // 현재 가장 하위에 있는 열린 메뉴
entry_choice_index = 0
entry_font_scale = 26 / 30 // -> fontLarge / fontMenuLarge

// 메뉴 항목 열거
event_user(0)

// 배경
// 서피스 두개 써서 구현할 것. 서피스 투명도 더하는 예제 찾아볼 것. 
bg_theme = theme.cave
SHOW = 0
OPENING = 10
FADEOUT = 90
bg_scene = SHOW

// 하단 정보
draw_set_font(fontSmall)
info_caption_copyright = "copyright 2020"
info_caption_brand = " iconstudio"
info_caption_brand_full = info_caption_copyright + info_caption_brand
info_caption_version = "version " + GM_version
info_drawn_y = global.resolutions_gui[1] - 4
info_brand_drawn_x = string_width(info_caption_copyright) + 4
info_brand_time = 0
info_brand_period = seconds(0.5)
