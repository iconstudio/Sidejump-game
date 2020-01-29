/// @description 챕터 보드에서 정보를 얻어서 갱신
if instance_exists(entry_upper) {
	scale = entry_upper.open_time / entry_upper.open_period

	if close {
		width = lerp(width_easing_start, 0, 1 - ease_out_quad(scale))
		if scale == 0 {
			instance_destroy()
			//callback_campaign_back()
		}
	} else {
		if width != width_max
			width = min(width + width_increase, width_max)
		width_easing_start = width
	}
} else {
	instance_destroy()
}

if created_time < created_period
	created_time++
else
	created_time = created_period
