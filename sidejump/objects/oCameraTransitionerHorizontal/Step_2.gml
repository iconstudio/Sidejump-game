/// @description 플레이어 충돌 감지
if instance_place(x, y, oPlayer) {
	if !player_collided {
		if x + 8 < oPlayer.x
			camera_set_transition(1, 0)
		else if oPlayer.x < x + 8
			camera_set_transition(-1, 0)
		camera_set_mode(camera_mode.transition_horizontal)
		player_collided = true
	}
} else {
	player_collided = false
}
