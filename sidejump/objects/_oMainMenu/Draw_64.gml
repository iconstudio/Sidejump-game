/// @description 주 메뉴 그리기
draw_set_alpha(image_alpha)

//draw_stack_push()
//var project_origin = draw_set_projection(0, 0, menu_perspective_distance, 0, 0, 0, 0, 1, 0)
//draw_transform_set_translation(800 - menu_scroll, 450, 0)

// 메뉴 항목 그리기
draw_set_color($ffffff)
draw_set_halign(1)
draw_set_valign(1)
for (var i = 0; i < menu_number; ++i) {
	var submenu_number = ds_list_size(menu_items[i])
	if 0 < submenu_number {
		for (var j = 0; j < submenu_number; ++j) {
			var menu_item = ds_list_find_value(menu_items[i], j)
			if !instance_exists(menu_item)
				show_error("메뉴 항목을 생성할 때 문제가 발생했습니다.", true)
			if !menu_item.shown
				continue

			var menu_ox = 800 - menu_scroll + i * menu_item_gap
			var menu_dx = menu_ox + menu_item.x - 800
			if menu_dx + menu_item_size_half <= 0 or 1600 < menu_dx - menu_item_size_half
				continue

			var menu_alpha = 0
			if i == menu_index
				menu_alpha = 1 - abs(menu_ox - 800) / menu_fade_size
			else 
				menu_alpha = 1 - abs(menu_dx - 800) / menu_fade_size
			if menu_index != menu_index_previous and menu_index_previous == i {
				if j == menu_item_selected[i]
					menu_alpha = 1 - abs(menu_ox - 800) / menu_fade_size
			}

			draw_set_alpha(image_alpha * menu_alpha)
			var menu_dy = menu_item.y// + menu_scroll_vertical
			draw_sprite(sMenuPanel, 0, menu_dx, menu_dy)
			draw_text(menu_dx, menu_dy, menu_item.caption)
		}
	}

	//draw_transform_add_translation(menu_item_gap, 0, 0)
}
draw_set_alpha(image_alpha)

//draw_transform_set_identity()
//draw_stack_pop()
//camera_set_view_mat(project_origin[0], project_origin[1])
//camera_apply(project_origin[0])

// 좌우 음영 그리기
draw_set_color(0)
gpu_set_blendmode(bm_subtract)
draw_rectangle_color(0, 0, menu_shade_size, 900, $ffffff, 0, 0, $ffffff, false)
draw_rectangle_color(1600 - menu_shade_size, 0, 1600, 900, 0,  $ffffff,  $ffffff, 0, false)
gpu_set_blendmode(bm_normal)
