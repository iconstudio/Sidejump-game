/// @description menu_get_y_last()
/// @function menu_get_y_last
function menu_get_y_last() {
	var y_summary = 0
	var y_index = 0

	for (var i = 0; i < ds_list_size(entry_list); ++i) {
		var entry = menu_get_entry(i)
		with entry {
			if !use_custom_coords {
				var size = ds_list_size(entry_list)

				if 0 < size {
					if opened {
						var y_temp = menu_get_y_last()
						if y_temp[1] == size
							return [0, y_index]
						else
							return [y_summary + y_temp[0], y_index + y_temp[1]]
					} else {
						y_summary += height
						y_index++
					}
				} else {
					y_summary += height
					y_index++
				}
			}
		}
	}
	return [y_summary, y_index]



}
