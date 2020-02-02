/// @description 어플리케이션 서피스 그리기
/*

if !surface_exists(post_surface)
	event_user(0)

surface_set_target(post_surface)
draw_clear_alpha(0, 0)
gpu_set_blendmode_ext(bm_one, bm_zero)
draw_surface_stretched(application_surface, 0, 0, global.application_sizes[0], global.application_sizes[1])
gpu_set_blendmode(bm_normal)
surface_reset_target()

//shader_set(shaderFXAA)
draw_surface(post_surface, global.application_offset[0], global.application_offset[1])
//shader_reset()
