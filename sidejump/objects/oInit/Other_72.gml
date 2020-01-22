/// @description 오디오 불러오기
if ds_map_exists(async_load, "type") {
	var type = ds_map_find_value(async_load, "type")
	if type == "audiogroup_load" {
		var group_id = ds_map_find_value(async_load, "group_id")

		if group_id == audiogroup_everthing {
			audio_loaded = true
			
			if loading_failed
				audio_group_unload(audiogroup_everthing)
			else
				event_user(0)
		}
	}
}
