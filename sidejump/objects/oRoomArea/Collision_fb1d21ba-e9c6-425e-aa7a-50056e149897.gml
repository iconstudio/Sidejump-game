/// @description 구역 전환
var condition = false
if bbox_top < other.y and other.velocity_y < 0 // 위쪽
	condition = true
else if other.y < bbox_bottom and 0 < other.velocity_y // 아래쪽
	condition = true
else if bbox_left < other.x and other.velocity_x < 0 // 왼쪽
	condition = true
else if other.x < bbox_right and 0 < other.velocity_x // 오른쪽
	condition = true

if condition
	camera_set_area(id)
