/// @description 카메라 이동
if !instance_exists(target) and (mode == camera_mode.follow or mode == camera_mode.transition)
	exit

dest_x = 0
dest_y = 0
if origin_x != 0
	dest_x += origin_x
if origin_y != 0
	dest_y += origin_y

switch mode {
	case camera_mode.follow:
		#region follow
		if !instance_exists(global.game_area)
			exit

		dest_x += target.x
		dest_y += target.y
		if !area_is_small
			event_user(0)
		else if instance_exists(area_previous)
			event_user(1)

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
		if !instance_exists(global.game_area)
			exit

		dest_x += target.x
		dest_y += target.y
		if !area_is_small
			event_user(0)
		else if instance_exists(area_previous)
			event_user(1)

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
				mode = camera_mode.follow

				instance_activate_all()
				with global.game_area
					instance_deactivate_region(bbox_left - 32, bbox_top - 32, bbox_right - bbox_left + 64, bbox_bottom - bbox_top + 64, false, true)
				instance_activate_object(oIgnore)
				instance_activate_object(oPlayer)
				instance_activate_object(oLightObject)
				if area_is_small {
					game_area_activate(area_previous)
				}
				game_set_spawn_point(instance_nearest(target.x, target.y, oSpawnPoint))
			}
		}
		#endregion
	break

	default:
	break
}


