/// @description 오른쪽 접지
move_contact_solid(0, abs(velocity_x) + 1)
move_outside_solid(180, 1)
jump_sideoff_time = 0
if 0 < velocity_x
	velocity_x -= friction_x
else
	velocity_x = 0
