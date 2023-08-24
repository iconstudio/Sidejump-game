/// @description move_vertical(movement)
/// @function move_vertical
/// @param movement { real }
function move_vertical(argument0) {
	var movement = round(abs(argument0))
	if 0 < argument0 {
		while 1 <= movement {
			if check_bottom(1)
				break

			y++
			movement--
		}
		if check_bottom(0)
			y--
	} else if argument0 < 0 {
		while 1 <= movement {
			if check_top(1)
				break

			y--
			movement--
		}
		if check_top(0)
			y++
	}



}
