/// @description 페이드 인, 아웃
if fadein {
	image_alpha = fadein_time / fadein_period

	if fadein_time < fadein_period {
		fadein_time++
	} else {
		fadein = false
		fadein_time = 0
	}
} else {
	var mx_previous = device_mouse_x_to_gui(0)
	var my_previous = device_mouse_y_to_gui(0)
	if mx_previous != mx_check or my_previous != my_check {
		image_alpha = 1
		mx_check = mx_previous
		my_check = my_previous
		await_time = 0
		fadeout_time = 0
	} else {
		image_alpha = 1 - fadeout_time / fadeout_period

		if await_time < await_period {
			await_time++
		} else {
			if fadeout_time < fadeout_period {
				fadeout_time++
			} else {
				fadeout_time = fadeout_period
			}
		}
	}
}
