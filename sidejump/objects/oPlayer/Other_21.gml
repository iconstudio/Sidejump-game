/// @description 왼쪽 접지
move_contact_solid(180, abs(velocity_x) + 1)
move_outside_solid(0, 1)
jump_sideoff_time = 0
if velocity_x < 0
	velocity_x += friction_x
else
	velocity_x = 0
