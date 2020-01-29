/// @description 캠페인 정보 그리기
var alpha_before = draw_get_alpha()
draw_set_color(0)
draw_set_alpha(1)
draw_rectangle_size(x, y, width, height, false)
draw_set_alpha(alpha_before)
