/// @description 네트워크 상태 갱신
global.network_available = os_is_network_connected()
alarm[0] = network_update_period
