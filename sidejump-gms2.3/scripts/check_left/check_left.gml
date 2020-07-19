/// @description check_left(distance)
/// @function check_left
/// @param distance { real }
function check_left(argument0) {
	if 0 < argument0 {
		return 0 < instance_place(x - argument0, y, oSolidParent)
		or 0 < instance_place(x - argument0, y, oNonsolidBlock)
	} else if argument0 < 0 {
		return false
	}



}
