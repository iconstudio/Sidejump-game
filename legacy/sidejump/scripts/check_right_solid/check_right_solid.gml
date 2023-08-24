/// @description check_right(distance)
/// @function check_right
/// @param distance { real }
if 0 < argument0 {
	return 0 < collision_rectangle(bbox_right + 1, bbox_top, bbox_right + argument0, bbox_bottom, oSolidParent, false, true)
} else if argument0 < 0 {
	return false
}
