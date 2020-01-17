/// @description 왼쪽 접지
jump_sideoff_time = 0
if velocity_x < 0
	velocity_x = min(0, velocity_x + friction_x)
