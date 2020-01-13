/// @description move_horizontal(movement)
/// @function move_horizontal
/// @param movement { real }
if 0 < argument0 {
	if place_free(x + 1, y)
		move_contact_solid(0, argument0)
} else if argument0 < 0 {
	if place_free(x - 1, y)
		move_contact_solid(180, -argument0)
}
