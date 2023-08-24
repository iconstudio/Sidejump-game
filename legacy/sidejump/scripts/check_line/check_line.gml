/// @description check_line(dest_x, dest_y)
/// @function check_lline
/// @param dest_x { real }
/// @param dest_y { real }
if 0 < argument0 {
	return 0 < collision_line(x, y, argument0, argument1, oSolidParent, true, true) 
} else if argument0 < 0 {
	return false
}
