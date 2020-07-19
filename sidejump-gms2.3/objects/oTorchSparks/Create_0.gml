spark_alpha_begin = 0.2 + random(1)
spark_alpha_end = random(2) * 0.2
spark_alpha_time = 0
spark_alpha_period = seconds(0.1 + random(1))
image_alpha = spark_alpha_begin

spark_alpha_wiggle_value = 0.03 + random(0.05)
spark_alpha_wiggle_time = 0
spark_alpha_wiggle_period = seconds(0.05 + random(0.1))

disappear_time = 0
disappear_period = spark_alpha_period

image_blend_red = 110
image_blend_green = 0
image_blend_blue = 0
image_blend_time = 0
image_blend_period = seconds(0.6 + random(1))
image_blend_period_first = seconds(0.1 + random(0.1))

PIECE = 0 // 빨강색 -> 검정색
SPARK = 1 // 빨강색 -> 하양색
ASH = 2 // 검정색 -> 회색
type = choose(PIECE, PIECE, PIECE, PIECE, SPARK, SPARK, SPARK, SPARK, ASH)
if type == PIECE {
	disappear_period += seconds(0.3 + random(1.5))
	image_blend_period_first += seconds(0.5)
	image_blend_red += irandom(32)
} else if type == SPARK {
	disappear_period += seconds(1 + random(2))
	image_blend_red += irandom(32)
} else if type == ASH {
	disappear_period += seconds(0.9 + random(3))
	image_blend_period_first += SECOND
	image_blend_red = 0
}
image_blend = make_color_rgb(image_blend_red, image_blend_green, image_blend_blue)

//hspeed = 4 / seconds(0.5 + random(0.2)) * choose(-1, 1)
vspeed = -20 / seconds(0.3 + random(0.7))
image_yscale = 1 + random(3)
