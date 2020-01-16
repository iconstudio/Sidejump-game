/// @description 느려짐
if 0 < other.life {
	other.life--
	velocity_x *= 0.1
	velocity_y *= 0.7
	if place_free(x, y + 1)
		velocity_y += velocity_gravity_web
	//show_debug_message(velocity_y)
}
