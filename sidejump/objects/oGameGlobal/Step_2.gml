/// @description 플레이어 낙하 처리
if instance_exists(oPlayer) {
	if home.bbox_bottom < oPlayer.bbox_top and !collision_line(home.bbox_left, home.bbox_bottom + 1, home.bbox_right, home.bbox_bottom + 1, oSpawnArea, false, true) {
		player_die()
	}
}
