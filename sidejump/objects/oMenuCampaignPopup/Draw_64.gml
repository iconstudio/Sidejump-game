/// @description 팝업과 내용, 버튼 그리기
if !surface_exists(popup_surface)
	event_user(1)

if 0 < scale {
	//draw_set_color($ffffff)
	//draw_rectangle(global.resolutions_gui[0] - width, 0
	//, global.resolutions_gui[0], global.resolutions_gui[1], false)

	var alpha_before = draw_get_alpha()
	draw_set_alpha(alpha_before * ease_in_expo(scale))
	var dx = content_margin
	var dy = content_margin
	var dy2 = content_buttons_y

	surface_set_target(popup_surface)
	draw_clear($ffffff)
	with entry_upper {
		// 서피스로 그릴 것
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

