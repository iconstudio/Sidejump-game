/// @description 팝업과 내용, 버튼 그리기
if !surface_exists(popup_surface)
	event_user(1)

if !surface_exists(menu_blur_surface1) or !surface_exists(menu_blur_surface2)
	event_user(2)

if 0 < scale {
	var alpha_before = draw_get_alpha()
	var popup_alpha = alpha_before * ease_out_quartic(scale)
	draw_set_alpha(popup_alpha)

	gpu_set_texfilter(true)
	/*
	if setting_get_value("graphics") != 0 {
		surface_set_target(menu_blur_surface2)
		draw_clear_alpha(0, 0)
		gpu_set_blendmode(bm_add)
		
		var w_new = global.resolutions_gui[0] * 0.5
		var h_new = global.resolutions_gui[1] * 0.5
		draw_surface_stretched_ext(application_surface, 0, 1.5, w_new, h_new, $ffffff, 0.35)
		draw_surface_stretched_ext(application_surface, 1.5, 0, w_new, h_new, $ffffff, 0.35)
		draw_surface_stretched_ext(application_surface, 0, -1.5, w_new, h_new, $ffffff, 0.35)
		draw_surface_stretched_ext(application_surface, -1.5, 0, w_new, h_new, $ffffff, 0.35)
		with oMainMenu {
			if surface_exists(menu_surface) {
				draw_surface_stretched_ext(menu_surface, 0, 1.5, w_new, h_new, $ffffff, 0.35)
				draw_surface_stretched_ext(menu_surface, 1.5, 0, w_new, h_new, $ffffff, 0.35)
				draw_surface_stretched_ext(menu_surface, 0, -1.5, w_new, h_new, $ffffff, 0.35)
				draw_surface_stretched_ext(menu_surface, -1.5, 0, w_new, h_new, $ffffff, 0.35)
			}
		}
		gpu_set_blendmode(bm_normal)
		surface_reset_target()

		surface_set_target(menu_blur_surface1)
		draw_surface_ext(application_surface, 0, 0, 1, 1, 0, $ffffff, 1)
		draw_surface_ext(menu_blur_surface2, 0, 0, 2, 2, 0, $ffffff, 1)
		surface_reset_target()
		

		shader_set(shaderBlurCentral)
		//draw_surface_ext(menu_blur_surface1, 0, 0, 1, 1, 0, $ffffff, draw_get_alpha())
		var x_new = global.application_offset[0]
		var y_new = global.application_offset[1]
		draw_surface_ext(application_surface, x_new, y_new, 1, 1, 0, $ffffff, draw_get_alpha())
		with oMainMenu {
			if surface_exists(menu_surface)
				draw_surface_ext(menu_surface, 0, 0, 1, 1, 0, $ffffff, draw_get_alpha())
		}
		shader_reset()
		gpu_set_texfilter(false)
	}
	draw_set_color(0)
	draw_set_alpha(popup_alpha * 0.5)
	draw_rectangle(0, 0, global.resolutions_gui[0], global.resolutions_gui[1], false)
	draw_set_alpha(popup_alpha)

	/*if setting_get_value("graphics") == 2 {
		
		shader_set(shaderBlur)
		with oMainMenu {
			if surface_exists(menu_surface)
				draw_surface_ext(menu_surface, 0, 0, 1, 1, 0, $ffffff, draw_get_alpha())
		}
		shader_reset()
	} else if setting_get_value("graphics") == 1 {
		draw_set_color(0)
		draw_set_alpha(popup_alpha * 0.5)
		draw_rectangle(0, 0, global.resolutions_gui[0], global.resolutions_gui[1], false)
		draw_set_alpha(popup_alpha)
	}*/

	var dx = content_margin
	var dy = content_margin
	var dy2 = content_buttons_y

	draw_set_alpha(alpha_before * ease_in_expo(scale))
	surface_set_target(popup_surface)
	draw_clear($ffffff)
	with entry_upper {
		with info_campaign {
			x = dx
			y = dy
			event_user(0)
			dy += height
		}

		dy = dy2
		with button_start {
			custom_x = dx
			custom_y = dy
			event_user(0)
			dy += height
		}
		with button_back {
			custom_x = dx
			custom_y = dy
			event_user(0)
			dy += height
		}
	}
	surface_reset_target()
	draw_set_alpha(alpha_before)

	var surface_drawn_x = global.resolutions_gui[0] - width
	draw_surface_ext(popup_surface, surface_drawn_x, 0, 1, 1, 0, $ffffff, draw_get_alpha())
	draw_sprite_ext(sChapterGlow, 0, surface_drawn_x, 0, 1, glow_scale, 0, $ffffff, draw_get_alpha())
}

