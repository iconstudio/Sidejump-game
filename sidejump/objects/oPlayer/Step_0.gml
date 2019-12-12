/// @description 동작


var movement_x = keyboard_check(vk_right) - keyboard_check(vk_left)
if movement_x != 0 
	velocity_x += movement_x

if keyboard_check_pressed(vk_up) and !place_free(x, y + 1) and place_free(x, y - 1)
	velocity_y += jump_velocity

if velocity_x != 0 {
	var check_x
	if 0 <velocity_x
		check_x = x + velocity_x + 1
	else if velocity_x < 0
		check_x = x + velocity_x - 1

	if place_free(check_x, y) {
		x += velocity_x
	} else {
		if velocity_x > 0
			move_contact_solid(0, abs(velocity_x) + 1)
		else if velocity_x < 0
			move_contact_solid(180, abs(velocity_x) + 1)

		velocity_x = 0
	}
}

var check_y
if velocity_y < 0
	check_y = y + velocity_y - 1
else
	check_y = y + velocity_y + 1

if !place_free(x, check_y) {
	if velocity_y > 0 {
		move_contact_solid(270, abs(velocity_y) + 1)
		move_outside_solid(90, 1)
	} else if velocity_y < 0 {
		move_contact_solid(90, abs(velocity_y) + 1)
	}

	velocity_y = 0
} else { 
	y += velocity_y
	velocity_y += velocity_gravity
}

if abs(velocity_x) > velocity_x_limit
	velocity_x = velocity_x_limit * sign(velocity_x)

if velocity_y > velocity_y_max
	velocity_y = velocity_y_max
else if velocity_y < velocity_y_min
	velocity_y = velocity_y_min

if movement_x == 0 and velocity_x != 0 and friction_x != 0 {
	if !place_free(x, y + 1)
		velocity_x -= friction_x * velocity_x
	else
		velocity_x -= friction_x_air * velocity_x
}
if velocity_y != 0 and friction_y != 0
	velocity_y -= friction_y * velocity_y
