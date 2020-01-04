/// @description move_vertical(movement)
/// @function move_vertical
/// @param movement { real }
if 0 < argument0
	move_contact_solid(270, argument0)
else if argument0 < 0
	move_contact_solid(90, -argument0)
