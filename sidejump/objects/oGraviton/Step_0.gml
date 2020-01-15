/// @description 동작
if velocity_x != 0 {
	var velocity_x_real = velocity(velocity_x)
	var check_x = x + velocity_x_real + sign(velocity_x_real)
	
	if instance_place(check_x, y, oNonsolidBlock) {
		if 0 < velocity_x_real {
			for (var i = velocity_x_real; !instance_place(x + 1, y, oNonsolidBlock); --i) {
				x++
			}
		} else if velocity_x_real < 0 {
			for (var i = -velocity_x_real; !instance_place(x - 1, y, oNonsolidBlock); --i) {
				x--
			}
		}
		velocity_x = 0
	} else if place_free(check_x, y) {
		var cliffoff_check = false
		if !cliffoff and 0 <= velocity_y
			cliffoff_check = !place_free(x, y + 1)

		x += velocity_x_real

		if cliffoff_check and place_free(x, y + 1)
			cliffoff = true
	} else if slope_climbable and place_free(check_x, y - slope_upper_limit) {
		x += velocity_x_real
		y -= slope_upper_limit
		if velocity_y <= 0
			move_contact_solid(270, slope_upper_limit)
	} else {
		if 0 < velocity_x_real
			event_user(10)
		else if velocity_x_real < 0
			event_user(11)
	}
}

if place_free(x, y + 1)
	velocity_y += velocity_gravity
if velocity_y != 0 {
	var velocity_y_real = velocity(velocity_y)
	move_vertical(velocity_y_real)

	var check_y = velocity_y_real < 0 ? y - 1 : y + 1
	if !place_free(x, check_y) {
		if velocity_y_real < 0
			event_user(13)
		else
			event_user(12)
	}
}

if 0 < velocity_y and velocity_y_max_in_gravity - velocity_y < velocity_y_gap_in_gravity
	velocity_y = velocity_y_max_in_gravity

event_user(14)

if velocity_x_limit < abs(velocity_x)
	velocity_x = velocity_x_limit * sign(velocity_x)

if velocity_y_max < velocity_y
	velocity_y = velocity_y_max
else if velocity_y < velocity_y_min
	velocity_y = velocity_y_min
