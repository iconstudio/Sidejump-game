/// @description 불꽃 생성
repeat 1 + choose(0, 1, 1, 1, 2, 2, 3)
	instance_create_layer(x + random_range(6, 10), y - 9, "Effects_Middle", oTorchSparks)

alarm[0] = 1 + random(spark_period_max)
