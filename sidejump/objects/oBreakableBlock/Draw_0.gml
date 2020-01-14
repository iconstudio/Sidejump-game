/// @description 흔들림
if breaking {
	if life < life_max * 0.2 {
		draw_ax = random_range(-1, 1) * 4
		draw_ay = random_range(-1, 1) * 4
		draw_sprite_ext(sprite_index, -1, x + draw_ax, y + draw_ay, image_xscale, image_yscale, image_angle, image_blend, image_alpha * 0.1)
	}

	draw_ax = random_range(-1, 1) * 2
	draw_ay = random_range(-1, 1) * 2
	draw_sprite_ext(sprite_index, -1, x + draw_ax, y + draw_ay, image_xscale, image_yscale, image_angle, image_blend, image_alpha * 0.5)

	draw_ax = random_range(-1, 1)
	draw_ay = random_range(-1, 1)
	draw_sprite_ext(sprite_index, -1, x + draw_ax, y + draw_ay, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
} else {
	draw_sprite_ext(sprite_index, -1, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
}
