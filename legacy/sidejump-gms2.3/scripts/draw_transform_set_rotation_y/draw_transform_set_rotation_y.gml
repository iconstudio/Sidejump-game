/// @description draw_transform_set_rotation_y(angle)
/// @function draw_transform_set_rotation_y
/// @param angle { real }
function draw_transform_set_rotation_y(argument0) {
	var c = dcos(argument0)
	var s = dsin(argument0)
	var m = matrix_build_identity()
	m[0] = c
	m[2] = s
	m[8] = -s
	m[10] = c
	matrix_set(matrix_world, m)



}
