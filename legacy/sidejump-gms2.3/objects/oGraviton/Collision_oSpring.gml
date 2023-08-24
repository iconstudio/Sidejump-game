/// @description 위쪽으로 튀어오르기
if !other.sprung {
	velocity_y = -other.sprung_speed
	cliffoff = false
	move_vertical(-2)
	other.sprung_target = id
	with other
		event_user(0)
}
