/// @description 영역 일부분 제한
if global.game_area.x < area_previous.x // from right to left
	dest_x = max(global.game_area.bbox_left + center_x, dest_x)
else if area_previous.x < global.game_area.x
	dest_x = min(global.game_area.bbox_right - left_x, dest_x)
else
	dest_x = max(global.game_area.bbox_left + center_x, min(global.game_area.bbox_right - left_x, dest_x))

if global.game_area.y < area_previous.y // from bottom to top
	dest_y = max(global.game_area.bbox_top + center_y, dest_y)
else if area_previous.y < global.game_area.y
	dest_y = min(global.game_area.bbox_bottom - left_y, dest_y)
else
	dest_y = max(global.game_area.bbox_top + center_y, min(global.game_area.bbox_bottom - left_y, dest_y))
