/// @description 카메라 영역 제한
dest_x = max(global.game_area.bbox_left + center_x, min(global.game_area.bbox_right - left_x, dest_x))
dest_y = max(global.game_area.bbox_top + center_y, min(global.game_area.bbox_bottom - left_y, dest_y))
