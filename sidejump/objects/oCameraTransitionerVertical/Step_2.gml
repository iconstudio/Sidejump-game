/// @description 플레이어 충돌 감지
if instance_place(x, y, oPlayer) {
	if !player_collided {
		if oPlayer.velocity_y < 0 {
			camera_set_transition(0, -1)
			oPlayer.y -= 4
		} else {
			camera_set_transition(0, 1)
			oPlayer.y += 4
		}
		camera_set_mode(camera_mode.transition_vertical)
		player_collided = true
	}
} else {
	player_collided = false
}
