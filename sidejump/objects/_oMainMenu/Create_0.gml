NONE = 0
MENU_EXTENDING = 2
MENU_CLOSING = 3
EXIT = 99
menu_mode = NONE

LEFT = 0
RIGHT = 1
UP = 2
DOWN = 3
draw_set_font(fontMenu)

// 
menu_item_size_half = 280
menu_item_margin_size = 32
menu_item_size_half = menu_item_size_half + menu_item_margin_size
menu_item_gap = menu_item_size_half * 2 + menu_item_margin_size
menu_fade_size = menu_item_gap + menu_item_margin_size
menu_shade_size = 370
menu_coordinates = array_create(4)
menu_coordinates[LEFT] = [menu_item_size_half, 180]
menu_coordinates[RIGHT] = [menu_item_size_half, 0]
menu_coordinates[UP] = [menu_item_size_half, 90]
menu_coordinates[DOWN] = [menu_item_size_half, 270]

// 
menu_number = 0
menu_items = 0
menu_items_number = 0
menu_item_selected = 0
//menu_challange_continue = menu_create()
//menu_item_add(menu_challange_continue, "시작", LEFT, -1)
//menu_item_add(menu_challange_continue, "정보", UP, -1)
//menu_item_add(menu_challange_continue, "다시 시작", DOWN, -1)
//menu_item_add(menu_challange_continue, "", RIGHT, menu_callback_back_to_right, false)

menu_challange = menu_create() // 무한 모드
menu_item_add(menu_challange, "계속", LEFT, -1)
menu_item_add(menu_challange, "기록", UP, -1)
menu_item_add(menu_challange, "다시 시작", DOWN, -1)
menu_item_add(menu_challange, "", RIGHT, menu_callback_back_to_right, false)

menu_main = menu_create() // 메인
menu_item_add(menu_main, "도전", LEFT, menu_callback_challenge)
menu_item_add(menu_main, "플레이", RIGHT, menu_callback_game)
menu_item_add(menu_main, "설정", UP, -1)
menu_item_add(menu_main, "종료", DOWN, -1)
menu_center = menu_main

menu_game = menu_create() // 플레이
menu_item_add(menu_game, "캠페인", RIGHT, -1)
menu_item_add(menu_game, "튜토리얼", UP, -1)
menu_item_add(menu_game, "대전", DOWN, -1, true, false)
menu_item_add(menu_game, "", LEFT, menu_callback_back_to_left, false)

menu_campaign = menu_create()
menu_item_add(menu_campaign, "시작", RIGHT, -1)
menu_item_add(menu_campaign, "정보", UP, -1)
menu_item_add(menu_campaign, "다시 시작", DOWN, -1)
menu_item_add(menu_campaign, "", LEFT, menu_callback_back_to_left, false)

// 
menu_pushing = false // 방향키로 메뉴 전환 중 여부
menu_dragging = false // 마우스로 메뉴 드래그 중 여부
menu_item_extend_period = seconds(0.72)

// 
menu_index_previous = menu_center
menu_index = menu_index_previous
menu_select(menu_center)

menu_scroll_easer_default = ease_out_quartic
menu_scroll_easer_bounce = ease_out_elastic
menu_scroll_easer = menu_scroll_easer_default
menu_scroll_target = menu_index * menu_item_gap
menu_scroll_begin = menu_scroll_target
menu_scroll = menu_scroll_begin
menu_scroll_vertical = 0
menu_scroll_pre = menu_scroll_begin
menu_scroll_vertical_pre = 0

//
menu_drag_threshold = menu_item_gap * 0.5
menu_drag_threshold_vertical = menu_item_gap * 0.4
menu_drag_faraway = menu_item_gap * 0.9
menu_drag_lesseraway = menu_item_size_half * 0.333
menu_drag_begin = [0, 0]
menu_drag_mover_coord_begin = [-1, -1]
menu_push_period_max = seconds(0.4)
menu_push_period = menu_push_period_max
menu_push_time = menu_push_period
cursor_fast_count = 0
cursor_fast_threshold = 4
cursor_x = 0
cursor_y = 0
cursor_gui_x = 0
cursor_gui_y = 0
cursor_gui_x_previous = 0
cursor_gui_y_previous = 0

menu_perspective_distance = -400
