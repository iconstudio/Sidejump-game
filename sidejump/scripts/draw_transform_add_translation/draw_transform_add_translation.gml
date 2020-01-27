/// @description draw_transform_add_translation(xt, yt, zt)
/// @function draw_transform_add_translation
/// @param xt { real }
/// @param yt { real }
/// @param zt { real }
var m = matrix_build_identity()
m[12] = argument0
m[13] = argument1
m[14] = argument2

var mw = matrix_get(matrix_world)
var mr = matrix_multiply(mw, m)
matrix_set(matrix_world, mr)