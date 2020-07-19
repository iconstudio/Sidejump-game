if spark_alpha_time < spark_alpha_period {
	image_alpha = lerp(spark_alpha_begin, spark_alpha_end, spark_alpha_time / spark_alpha_period)

	spark_alpha_time++
} else {
	var wiggle_ratio = spark_alpha_wiggle_time / spark_alpha_wiggle_period
	var wiggle_rotation = 360 * wiggle_ratio
	var wiggle_alpha = lengthdir_y(spark_alpha_wiggle_value, wiggle_rotation)
	image_alpha = spark_alpha_end + wiggle_alpha

	spark_alpha_time = spark_alpha_period

	if spark_alpha_wiggle_time < spark_alpha_wiggle_period
		spark_alpha_wiggle_time++
	else
		spark_alpha_wiggle_time = 0
}

if disappear_time < disappear_period
	disappear_time++
else
	instance_destroy()

var new_red = image_blend_red
var new_green = image_blend_green
var new_blue = image_blend_blue
if type == PIECE {
	if image_blend_time < image_blend_period_first
		new_red = lerp(image_blend_red, 0, image_blend_time / image_blend_period_first)
} else if type == SPARK {
	var new_ratio = (image_blend_time - image_blend_period_first) / (image_blend_period - image_blend_period_first)
	if image_blend_time < image_blend_period_first {
		new_red = lerp(image_blend_red, 240, image_blend_time / image_blend_period_first)
	} else {
		new_red = 240
		new_green = lerp(image_blend_green, 255, new_ratio)
		new_blue = lerp(image_blend_blue, 255, new_ratio)
	}
} else if type == ASH {
	var new_ratio = (image_blend_time - image_blend_period_first) / (image_blend_period - image_blend_period_first)
	if image_blend_time < image_blend_period_first {
		
	} else {
		new_red = lerp(image_blend_red, 32, new_ratio)
		new_green = lerp(image_blend_green, 32, new_ratio)
		new_blue = lerp(image_blend_blue, 32, new_ratio)
	}
}
image_blend = make_color_rgb(new_red, new_green, new_blue)

if image_blend_time < disappear_period
	image_blend_time++
else
	image_blend_time = disappear_period

