/// @description 플레이어 낙하 처리
if instance_exists(oPlayer) {
	var area = global.game_area
	if room_height < oPlayer.bbox_top {
		player_die()
	} else if instance_exists(area) {
		if area.bbox_bottom < oPlayer.bbox_top and !collision_line(area.bbox_left, area.bbox_bottom + 1, area.bbox_right, area.bbox_bottom + 1, oSpawnArea, false, true) {
			player_die()
		}
	}
}
