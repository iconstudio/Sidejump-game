/// @description 로딩 계속하기
var async_id = ds_map_find_value(async_load, "id")
if async_id == loading_interrupt_msg {
	if  ds_map_find_value(async_load, "status")
		loading_continues = true
}
