/// @description check_left_solid(distance)
/// @function check_left_solid
/// @param distance { real }
function check_left_solid(argument0) {
	if 0 < argument0 {
		return 0 < collision_rectangle(bbox_left - 1, bbox_top, bbox_left - argument0, bbox_bottom, oSolidParent, false, true)
	} else if argument0 < 0 {
		return false
	}



}
