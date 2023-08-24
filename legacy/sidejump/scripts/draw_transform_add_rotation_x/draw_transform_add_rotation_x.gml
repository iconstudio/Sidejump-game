/// @description draw_transform_add_rotation_x(angle)
/// @function draw_transform_add_rotation_x
/// @param angle { real }
var c = dcos(argument0)
var s = dsin(argument0)
var m = matrix_build_identity()
m[5] = c
m[6] = -s
m[9] = s
m[10] = c

var mw = matrix_get( matrix_world )
var mr = matrix_multiply( mw, m )
matrix_set( matrix_world, mr )
