var player_collide = instance_place(x, y, oPlayer)
if 0 < player_collide {
	if !entered {
		entered = true
		with oGameGlobal
			home = instance_nearest(player_collide.x, player_collide.y, oSpawnPoint)
	}
} else {
	entered = false
}
