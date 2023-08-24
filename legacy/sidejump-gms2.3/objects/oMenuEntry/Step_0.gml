if opened {
	if open_time < open_period
		open_time++
	else
		open_time = open_period
} else {
	if 0 < open_time
		open_time--
	else
		open_time = 0
}

if created_time < created_period
	created_time++
else
	created_time = created_period
