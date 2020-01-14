if life <= 0 {
	if respawn_time < respawn_period {
		respawn_time++
		solid = false
		visible = false
	} else {
		breaking = false
		life = life_max
		respawn_time = 0
		solid = true
		visible = true
	}
}

if breaking
	life--
