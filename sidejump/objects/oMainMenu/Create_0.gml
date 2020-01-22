/// @description 메뉴 초기화
// 메뉴 장면
TITLE_APPEAR = 0
TITLE_IDLE = 1
TITLE_ENTER = 2
TITLE_EXIT = 90
x = room_width * 0.5
y = room_height * 0.5
title_alpha = 0
title_scale = 0

MAIN_APPEAR = 3
MAIN_IDLE = 4
MAIN_BACK_TO_TITLE = 20
MAIN_EXIT = 91
main_alpha = 0
scene = TITLE_APPEAR

// 메뉴 항목
menu_number = 0


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
