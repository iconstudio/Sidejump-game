/// @description check_right(distance)
/// @function check_right
/// @param distance { real }
if 0 < argument0 {
	return 0 < instance_place(x + argument0, y, oSolidParent)
	or 0 < instance_place(x + argument0, y, oNonsolidBlock)
	//return 0 < collision_rectangle(x, bbox_top, bbox_right + argument0 + 1, bbox_bottom, oSolidParent, false, true)
	//or 0 < collision_rectangle(x, bbox_top, bbox_right + argument0 + 1, bbox_bottom, oNonsolidBlock, false, true)
} else if argument0 < 0 {
	return false
}
