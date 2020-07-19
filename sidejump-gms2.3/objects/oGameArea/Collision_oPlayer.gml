/// @description 구역 전환
var condition = false
if other.bbox_bottom < bbox_bottom // 아래에서 위쪽으로
	condition = true
else if bbox_top <= other.bbox_top // 위에서 아래쪽으로
	condition = true
else if other.x < bbox_right and other.velocity_x < 0 // 왼쪽으로
	condition = true
else if bbox_left <= other.x and 0 < other.velocity_x // 오른쪽으로
	condition = true

if condition
	game_set_area(id)
