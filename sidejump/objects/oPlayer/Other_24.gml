/// @description 마찰력 적용
if accel_x == 0 and velocity_x != 0 and movement_preserve_time == 0 {
	if abs(velocity_x) < friction_x
		velocity_x = 0
	else
		velocity_x -= friction_x * sign(velocity_x)
}

if velocity_y != 0 and friction_y != 0 {
	if abs(velocity_y) < friction_y
		velocity_y = 0
	else
		velocity_y -= friction_y * sign(velocity_y)
}

if place_free(x, y + 1)
	friction_x = friction_x_air
else
	friction_x = friction_x_ground
