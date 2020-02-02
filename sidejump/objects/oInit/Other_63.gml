/// @description 네트워크 메시지 확인
var async_id = ds_map_find_value(async_load, "id")
if async_id == network_interrupt_msg {
	if ds_map_find_value(async_load, "status") {
		loading_failed = true
		alarm[1] = seconds(2)
	}
}
