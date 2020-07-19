index = -1
type = 0
meter = 0
pad_list = ds_priority_create()
//gamepad_sprite = [sIconControllerXbox, sIconControllerPlayStation, sIconControllerOther]

if gamepad_is_supported() {
	var gp_number = gamepad_get_device_count()
	
	if gp_number > 0 {
		for (var i = 0; i < gp_number; ++i) {
			if gamepad_is_connected(i)
				ds_priority_add(pad_list, i, i)
		}

		if 0 < ds_priority_size(pad_list) {
			index = ds_priority_find_min(pad_list) // pick only the first controller
			var cerif = string_lower(gamepad_get_description(index))
			if string_pos("xbox", cerif) != 0 {
				type = gamepad_type_xbox
			} else if string_pos("playstation", cerif) != 0 {
				type = gamepad_type_playstation
			} else {
				type = gamepad_type_other
			}
		}
	}
} else {
	instance_destroy()
}
