/// @description 게임 패드 인식
switch async_load[? "event_type"] {
	case "gamepad discovered":
		var new_index = async_load[? "pad_index"]
		if new_index >= 0 and index != new_index {
			ds_priority_add(pad_list, new_index, new_index)

			index = ds_priority_find_min(pad_list) // pick only the first controller
			if index == new_index {
				var description = "", cerif = string_lower(gamepad_get_description(index))
				if string_pos("xbox", cerif) != 0 {
					description = "XBOX GAMEPAD"
					type = gamepad_type_xbox
				} else if string_pos("playstation", cerif) != 0 {
					description = "PLAYSTATION GAMEPAD"
					type = gamepad_type_playstation
				} else {
					description = "OTHER GAMEPAD"
					type = gamepad_type_other
				}
				//notification_add(gamepad_sprite, "GAMEPAD RECOGNIZED", description)
			}

			show_debug_message("gamepad plug in")
		}
	break

	case "gamepad lost":
		var out_index = async_load[? "pad_index"]
		ds_priority_delete_value(pad_list, out_index)

		if 0 < ds_priority_size(pad_list) {
			//if index == out_index
				//notification_add(sIconControllerOff, "GAMEPAD DISCONNECTED", "")
			index = ds_priority_find_min(pad_list)
		} else {
			index = -1
			//show_error("게임 패드의 연결이 올바르게 끊어지지 않았습니다.", false)
		}
		show_debug_message("Gamepad plug out")
	break

	default:
	break
}
