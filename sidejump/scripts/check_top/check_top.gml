/// @description check_top(distance)
/// @function check_top
/// @param distance { real }
if 0 < argument0 {
	return 0 < instance_place(x, y - argument0, oSolidParent)
} else if argument0 < 0 {
	return false
}
