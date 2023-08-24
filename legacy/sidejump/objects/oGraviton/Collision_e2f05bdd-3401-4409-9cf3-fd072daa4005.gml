/// @description 오른쪽으로 튀어오르기
if !other.sprung {
	velocity_x = other.sprung_speed
	velocity_y = -100
	cliffoff = false
	move_horizontal(2)
	other.sprung_target = id
	with other
		event_user(0)
}
