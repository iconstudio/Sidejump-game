/// @description 동작
if velocity_x != 0 {
	var check_x = x + velocity_x + sign(velocity_x)
	if place_free(check_x, y) {
		x += velocity_x
	} else {
		if 0 < velocity_x
			event_user(10)
		else if velocity_x < 0
			event_user(11)
	}
}

var check_y = velocity_y < 0 ? y + velocity_y - 1 : y + velocity_y + 1
if !place_free(x, check_y) {
	if 0 < velocity_y {
		move_contact_solid(270, abs(velocity_y) + 1)
		move_outside_solid(90, 1)
		y = floor(y)
	} else if velocity_y < 0 {
		move_contact_solid(90, abs(velocity_y) + 1)
	}

	velocity_y = 0
} else { 
	y += velocity_y
	velocity_y += velocity_gravity
}

if accel_x == 0 and velocity_x != 0 and friction_x != 0 {
	if !place_free(x, y + 1) {
		if abs(velocity_x) < friction_x
			velocity_x = 0
		else
			velocity_x -= friction_x * sign(velocity_x)
	} else {
		if abs(velocity_x) < friction_x_air
			velocity_x = 0
		else
			velocity_x -= friction_x_air * sign(velocity_x)
	}
}
if velocity_y != 0 and friction_y != 0
	velocity_y -= friction_y * sign(velocity_y)

if velocity_x_limit < abs(velocity_x)
	velocity_x = velocity_x_limit * sign(velocity_x)

if velocity_y_max < velocity_y
	velocity_y = velocity_y_max
else if velocity_y < velocity_y_min
	velocity_y = velocity_y_min
