if respawn_time < respawn_period
	respawn_time++
else
	instance_change(oBreakableBlock, true)
