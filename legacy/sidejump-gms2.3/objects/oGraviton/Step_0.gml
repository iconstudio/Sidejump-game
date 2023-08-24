/// @description 동작
if velocity_x != 0 {
	var velocity_x_real = velocity(velocity_x)
	var check_x = x + velocity_x_real + sign(velocity_x_real)

	var cliffoff_check = false
	
	if 0 < velocity_x_real {
		if check_right(velocity_x_real) {
			if slope_climbable and !check_line(check_x, y - slope_upper_limit) {
				x += velocity_x_real
				y -= slope_upper_limit
				if velocity_y <= 0
					move_vertical(slope_upper_limit)
			} else {
				move_horizontal(velocity_x_real)
				event_user(10)
			}
		} else {
			if !cliffoff and 0 <= velocity_y cliffoff_check = check_bottom(1)
			x += velocity_x_real
			if cliffoff_check and !check_bottom(1) cliffoff = true
		}
	} else {
		if check_left(-velocity_x_real) {
			if slope_climbable and !check_line(check_x, y - slope_upper_limit) {
				x += velocity_x_real
				y -= slope_upper_limit
				if velocity_y <= 0
					move_vertical(slope_upper_limit)
			} else {
				move_horizontal(velocity_x_real)
				event_user(11)
			}
		} else {
			if !cliffoff and 0 <= velocity_y cliffoff_check = check_bottom(1)
			x += velocity_x_real
			if cliffoff_check and !check_bottom(1) cliffoff = true
		}
	}
}

if !check_bottom(1)
	velocity_y += velocity_gravity
if 0 < velocity_y and velocity_y_max_in_gravity - velocity_y < velocity_y_gap_in_gravity
	velocity_y = velocity_y_max_in_gravity

if velocity_y != 0 {
	var velocity_y_real = velocity(velocity_y)
	if 0 < velocity_y_real {
		if check_bottom(velocity_y_real) {
			move_vertical(velocity_y_real + 1)
			event_user(13)
		} else {
			y += velocity_y_real
		}
	} else {
		if check_top(-velocity_y_real) {
			move_vertical(velocity_y_real - 1)
			event_user(12)
		} else {
			y += velocity_y_real
		}
	}
}

event_user(14)

if velocity_x_limit < abs(velocity_x)
	velocity_x = velocity_x_limit * sign(velocity_x)

if velocity_y_max < velocity_y
	velocity_y = velocity_y_max
else if velocity_y < velocity_y_min
	velocity_y = velocity_y_min
