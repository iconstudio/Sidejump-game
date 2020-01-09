/// @description 오른쪽 접지
move_horizontal(velocity(velocity_x) + 1)
jump_sideoff_time = 0
if 0 < velocity_x
	velocity_x = max(0, velocity_x - friction_x)
