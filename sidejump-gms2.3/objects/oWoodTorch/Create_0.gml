/// @description 재생 속도
event_inherited()

image_speed = 1 / seconds(0.06)

spark_period_max = seconds(0.2)
alarm[0] = 1 + random(spark_period_max)
