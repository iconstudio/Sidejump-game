/// @description move_horizontal(movement)
/// @function move_horizontal
/// @param movement { real }
var movement = abs(argument0)
if 0 < argument0 {
	while 1 <= movement {
		if check_right(1)
			break

		x++
		movement--
	}
	if check_right(0)
		x--
} else if argument0 < 0 {
	while 1 <= movement {
		if check_left(1)
			break

		x--
		movement--
	}
	if check_left(0)
		x++
}
