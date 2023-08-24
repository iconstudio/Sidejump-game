/// @description 용수철과 닿으면 점프가 아님
event_inherited()

if other.sprung_target == id {
	event_user(9)
	jumping = false
	grabbing = false
	hanging = false
	dashing = false
	player_prohibit_jumping()
}
