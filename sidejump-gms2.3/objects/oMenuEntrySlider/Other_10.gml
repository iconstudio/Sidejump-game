/// @description 슬라이더 그리기
if scale == 0
	exit

if !surface_exists(slide_surface)
	event_user(1)

var alpha_before = draw_get_alpha()

surface_set_target(slide_surface)
draw_clear_alpha(0, 0)

draw_set_alpha(alpha_before * ease_in_out_cubic(scale))

var bar_color = bar_color_unselected, bar_color_inner = bar_color_ranged_unselected
if entry_upper.entry_choice == id {
	bar_color = bar_color_normal
	bar_color_inner = bar_color_ranged
}
var drawn_begin_x = surface_width_margin
var drawn_begin_y = surface_height_margin
var drawn_y = drawn_begin_y + bar_y * scale
var bar_drawn_height = bar_height * scale

draw_set_color(bar_color)
draw_rectangle_size(drawn_begin_x, drawn_y, width, bar_drawn_height, false)

var grade_count = value_max - value_min + 1
if 1 < grade_count {
	draw_set_font(fontSmall)
	draw_set_halign(1)
	draw_set_valign(0)

	var grade_width = width / (grade_count - 1), grade_x, grade_x_next
	var text
	
	for (var i = 0; i < grade_count; ++i) {
		grade_x = drawn_begin_x + i * grade_width
		grade_x_next = grade_x + grade_width

		if i <= value {
			draw_set_color(bar_color_inner)
			if i < value_max and i <= value - 1 {
				draw_rectangle(grade_x, drawn_y, grade_x_next, drawn_y + bar_drawn_height, false)
			}
		} else {
			draw_set_color(bar_color)
		}
		draw_rectangle(grade_x, drawn_y - grade_height_half, grade_x + 1, drawn_y + grade_height_half + bar_drawn_height, false)

		draw_set_color($ffffff)
		if i == value
			draw_circle(grade_x, drawn_y + bar_drawn_height * 0.5, grade_height_half * 0.8, false)

		if script_exists(iterate_predicate)
			text = script_execute(iterate_predicate, i)
		else
			text = string(i)
		draw_text(grade_x, drawn_y + grade_height_half + 5, text)
	}
}

surface_reset_target()
draw_set_alpha(alpha_before)

if setting_get_value("graphics") != 0 {
	shader_set(shaderOutline)
	//shader_set_uniform_f(global.shaderOutline_resolution, width, height_max)
}
draw_surface_ext(slide_surface, x - surface_width_margin, y - surface_height_margin, 1, 1, 0, $ffffff, draw_get_alpha())
if setting_get_value("graphics") != 0 {
	//shader_set_uniform_f(global.shaderOutline_resolution, global.application_sizes[0], global.application_sizes[1])
	shader_reset()
}
