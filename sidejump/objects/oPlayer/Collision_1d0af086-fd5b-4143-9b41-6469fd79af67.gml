event_inherited()

if other.sprung_target == id {
	event_user(9)
	jumping = false
	hanging = false
	dashing = false
	player_prohibit_jumping()
	player_preserve_hspeed(movement_preserve_period_spring)
	player_prohibit_moving()
}
