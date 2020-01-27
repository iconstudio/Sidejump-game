/// @description 글꼴 크기 갱신
event_inherited()

if opened {
	var opening_ratio = ease_out_quad(open_time / open_period)
	height = lerp(opening_easing_start_height, height_max, opening_ratio)
	closing_easing_start_height = height
} else if 0 < open_time {
	var closing_ratio = 1 - ease_out_quad(open_time / open_period)
	height = lerp(closing_easing_start_height, height_min, closing_ratio)
	opening_easing_start_height = height
} else if instance_exists(entry_upper) {
	var upper_opening_ratio = ease_out_quad(entry_upper.open_time / entry_upper.open_period)
	if entry_upper.opened {
		height = lerp(0, height_min, upper_opening_ratio)
	} else  {
		height = lerp(height_min, 0, 1 - upper_opening_ratio)
	}
	opening_easing_start_height = height
	closing_easing_start_height = height
} else {
	if down_time < down_period {
		var opening_ratio = ease_out_quad(down_time / down_period)
		y = lerp(y_begin, ystart, opening_ratio)
		down_time++
	} else {
		y = ystart
	}
}
