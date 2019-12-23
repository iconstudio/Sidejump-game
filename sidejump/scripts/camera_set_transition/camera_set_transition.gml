/// @description camera_set_transition(kind)
/// @function camera_set_transition
/// @param kind { enumerate }
with oGameGlobal {
	camera.transition = argument0
	with camera {
		if transition == camera_transition.left
			x -= other.camerawork_transition_horizontal_velocity
		else if transition == camera_transition.up
			y -= other.camerawork_transition_vertical_velocity
		else if transition == camera_transition.right
			x += other.camerawork_transition_horizontal_velocity
		else if transition == camera_transition.down
			y += other.camerawork_transition_vertical_velocity
	}
}
