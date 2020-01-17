/// @description check_bottom(distance)
/// @function check_bottom
/// @param distance { real }
if 0 < argument0 {
	return 0 < instance_place(x, y + argument0, oSolidParent) or 0 < instance_place(x, y + argument0, oPlatformParent)
} else if argument0 < 0 {
	return false
}
