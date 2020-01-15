event_inherited()

if other.sprung_target == id {
	event_user(9)
	jumping = false
	grabbing = false
	hanging = false
	dashing = false
	player_prohibit_jumping()
	player_preserve_hspeed(SECOND)
	player_prohibit_moving()
}
