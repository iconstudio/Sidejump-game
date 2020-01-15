/// @description 카메라 이동
if !instance_exists(target) and (mode == camera_mode.dynamic or mode == camera_mode.transition)
	exit

dest_x = 0
dest_y = 0
if origin_x != 0
	dest_x += origin_x
if origin_y != 0
	dest_y += origin_y

switch mode {
	case camera_mode.dynamic:
		#region dynamic
		dest_x += target.x
		dest_y += target.y
		event_user(0)

		mp_linear_step_object(dest_x, dest_y, 10, oCameraBlock)
		#endregion
	break

	case camera_mode.fixed:
		#region fixed
		#endregion
	break

	case camera_mode.cutscene:
		#region cutscene
		#endregion
	break

	case camera_mode.transition:
		#region transitioning
		dest_x += target.x
		dest_y += target.y
		event_user(0)

		if camerawork_time < camerawork_transition_period {
			var camerawork_ratio = ease_out_quartic(camerawork_time / camerawork_transition_period)
			x = lerp(camerawork_coordinate_begin[0], dest_x, camerawork_ratio)
			y = lerp(camerawork_coordinate_begin[1], dest_y, camerawork_ratio)

			camerawork_time++

			if camerawork_transition_period <= camerawork_time
				camerawork_status = CLEARING
		} else {
			if camerawork_status == CLEARING {
				camerawork_time = camerawork_transition_period
				x = dest_x
				y = dest_y
				camerawork_status = NORMAL
				mode = camera_mode.dynamic

				//instance_deactivate_all(true)
				//instance_activate_object(oIgnore)
				//instance_activate_object(oPlayer)
				//instance_activate_object(oLightObject)
				//instance_activate_object(oIgnore)
				//instance_activate_object(oIgnore)
				//with area
				//	instance_activate_region(bbox_left, bbox_top, bbox_right - bbox_left, bbox_bottom - bbox_top, true)
				game_set_spawn_point(instance_nearest(target.x, target.y, oSpawnPoint))
			}
		}
		#endregion
	break

	default:
	break
}


