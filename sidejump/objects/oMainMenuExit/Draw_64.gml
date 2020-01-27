/// @description 그리기
if !surface_exists(selection_surface)
	event_user(0)

/*
shader_set(shaderMenuFadeout)
shader_set_uniform_f(global.shaderMenuFadeout_shroud_alpha, image_alpha * 0.5)
draw_surface_part(application_surface, 0, 0, global.resolutions_gui[0], alpha_shroud_y, 0, 0)
if surface_exists(oMainMenu.menu_surface)
	draw_surface_part(oMainMenu.menu_surface, 0, 0, global.resolutions_gui[0], alpha_shroud_y, 0, 0)
shader_reset()
*/
//*
gpu_set_blendmode_ext(bm_inv_dest_color, bm_inv_src_color)
draw_sprite_ext(sPointMask, 0, 0, 0, global.resolutions_gui[0], alpha_shroud_y, 0, $ffffff, 1)
gpu_set_blendmode(bm_add)
draw_sprite_ext(sPointMask, 0, 0, 0, global.resolutions_gui[0], alpha_shroud_y, 0, $ffffff, image_alpha * 0.1)
gpu_set_blendmode_ext(bm_inv_dest_color, bm_inv_src_color)
draw_sprite_ext(sPointMask, 0, 0, 0, global.resolutions_gui[0], alpha_shroud_y, 0, $ffffff, 1)
gpu_set_blendmode(bm_normal)
//*/
var drawn_question_y = fadeout ? ease_out_quad(textout_time / textout_period) * 30 : 0
draw_set_alpha(text_alpha)
draw_set_color($ffffff)
draw_set_font(fontLarge)
draw_set_halign(1)
draw_set_valign(2)
draw_text(gui_cx, gui_cy - 8 - drawn_question_y, "Really do you want to exit the game?")
draw_set_alpha(1)

surface_set_target(selection_surface)
draw_clear_alpha(0, 0)
draw_set_font(fontMedium)
draw_set_halign(1)
draw_set_valign(0)

if selection == 0
	draw_set_color($1BC0FC)
else
	draw_set_color($ffffff)
draw_text(global.resolutions_gui[0] * 0.35, 0, "Yes")
if selection == 1
	draw_set_color($1BC0FC)
else
	draw_set_color($ffffff)
draw_text(global.resolutions_gui[0] * 0.65, 0, "No")

surface_reset_target()

var drawn_awswer_y = fadeout ? (textout_time / textout_period) * 30 : 0
var drawn_surface_y = gui_cy + drawn_awswer_y
if text_alpha == 1 {
	draw_surface_ext(selection_surface, 0, drawn_surface_y, 1, 1, 0, $ffffff, text_alpha)
} else {
	var selection_height = text_alpha * 64
	//draw_surface_part_ext(selection_surface, 0, 64 - selection_height, global.resolutions_gui[0], selection_height, 0, drawn_surface_y, 1, 1, $ffffff, text_alpha)
	draw_surface_part_ext(selection_surface, 0, 64 - selection_height, global.resolutions_gui[0], selection_height, 0, drawn_surface_y, 1, 1, $ffffff, text_alpha)
}

