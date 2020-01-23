/// @description 글꼴 크기 갱신
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
