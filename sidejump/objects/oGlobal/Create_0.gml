/// @description 초기화
shader_set(shaderFXAA)
shader_set_uniform_f(global.shaderFXAA_vSize, 1 / global.application_sizes[0], 1 / global.application_sizes[1])
shader_reset()

event_user(0)
event_user(1)

network_update_period = seconds(3)
alarm[0] = network_update_period
