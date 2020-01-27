/// @description draw_transform_set_rotation_z(angle)
/// @function draw_transform_set_rotation_z
/// @param angle { real }
var c = dcos(argument0)
var s = dsin(argument0)
var m = matrix_build_identity()
m[0] = c
m[1] = -s
m[4] = s
m[5] = c
matrix_set(matrix_world, m)
