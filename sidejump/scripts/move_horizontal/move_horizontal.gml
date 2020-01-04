/// @description move_horizontal(movement)
/// @function move_horizontal
/// @param movement { real }
if 0 < argument0
	move_contact_solid(0, argument0)
else if argument0 < 0
	move_contact_solid(180, -argument0)
