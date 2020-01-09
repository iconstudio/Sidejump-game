/// @description 왼쪽 접지
move_horizontal(velocity(velocity_x) - 1)
jump_sideoff_time = 0
if velocity_x < 0
	velocity_x = min(0, velocity_x + friction_x)
