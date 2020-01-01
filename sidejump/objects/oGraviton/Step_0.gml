/// @description 동작
cliffoff = false
if velocity_x != 0 {
	var check_x = x + velocity_x + sign(velocity_x)
	if place_free(check_x, y) {
		var cliffoff_check = false
		if !cliffoff and 0 <= velocity_y
			cliffoff_check = !place_free(x, y + 1)

		x += velocity_x

		if cliffoff_check and place_free(x, y + 1) {
			cliffoff = true
			//show_debug_message("on")
		}
	} else if place_free(check_x, y - slope_upper_limit) {
		x += velocity_x
		y -= slope_upper_limit
		move_contact_solid(270, slope_upper_limit)
	} else {
		if 0 < velocity_x
			event_user(10)
		else if velocity_x < 0
			event_user(11)
	}
}

var check_y = velocity_y < 0 ? y + velocity_y - 1 : y + velocity_y + 1
if !place_free(x, check_y) {
	if velocity_y < 0
		event_user(13)
	else
		event_user(12)
} else { 
	y += velocity_y
	velocity_y += velocity_gravity

	if 0 < velocity_y and velocity_y_max_in_gravity - velocity_y < velocity_y_gap_in_gravity
		velocity_y = velocity_y_max_in_gravity
}

event_user(14)

if velocity_x_limit < abs(velocity_x)
	velocity_x = velocity_x_limit * sign(velocity_x)

if velocity_y_max < velocity_y
	velocity_y = velocity_y_max
else if velocity_y < velocity_y_min
	velocity_y = velocity_y_min
