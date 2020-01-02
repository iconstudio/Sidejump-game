/// @description 마찰력 적용
if velocity_x != 0 {
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

if jumping
	friction_x = friction_x_jumping
else if !place_free(x, y + 1)
	friction_x = friction_x_air
else
	friction_x = friction_x_ground
