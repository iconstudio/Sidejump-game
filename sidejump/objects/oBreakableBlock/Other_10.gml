/// @description 위나 옆에서 충돌
if bbox_bottom <= other.bbox_top
	exit

var lhb = instance_place(x - 1, y, object_index)
while instance_exists(lhb) {
	lhb.breaking = true

	with lhb
		lhb = instance_place(x - 1, y, object_index)
}

var rhb = instance_place(x + 1, y, object_index)
while instance_exists(rhb) {
	rhb.breaking = true

	with rhb
		rhb = instance_place(x + 1, y, object_index)
}

breaking = true
