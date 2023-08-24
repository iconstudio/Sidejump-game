/// @description 후처리 서피스 생성
post_surface = surface_create(global.application_sizes[0], global.application_sizes[1])
surface_set_target(post_surface)
draw_clear_alpha(0, 0)
surface_reset_target()
