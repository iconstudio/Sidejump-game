/// @description 카메라 이동
if !instance_exists(target) and (mode != camera_mode.fixed and mode != camera_mode.cutscene)
	exit

var target_x, target_y
switch postition {
	case camera_position.left_up:
		target_x = -width * 0.5 + border
		target_y = -height * 0.5 + border
	break

	case camera_position.left_middle:
		target_x = -width * 0.5 + border
		target_y = 0
	break

	case camera_position.left_down:
		target_x = -width * 0.5 + border
		target_y = height * 0.5 - border
	break

	case camera_position.center_up:
		target_x = 0
		target_y = -height * 0.5 + border
	break

	case camera_position.center_middle:
		target_x = 0
		target_y = 0
	break

	case camera_position.center_down:
		target_x = 0
		target_y = height * 0.5 - border
	break

	case camera_position.right_up:
		target_x = width * 0.5 - border
		target_y = -height * 0.5 + border
	break

	case camera_position.right_middle:
		target_x = width * 0.5 - border
		target_y = 0
	break

	case camera_position.right_down:
		target_x = width * 0.5 - border
		target_y = height * 0.5 - border
	break

	default:
	break
}

if origin_x != 0
	target_x += origin_x
if origin_y != 0
	target_y += origin_y

switch mode {
	case camera_mode.dynamic:
		#region dynamic
		target_x += target.x
		target_y += target.y
		if instance_exists(area) {
			target_x = max(area.bbox_left + anchor_x * width, min(area.bbox_right - (1 - anchor_x) * width, target_x))
			target_y = max(area.bbox_top + anchor_y * height, min(area.bbox_bottom - (1 - anchor_y) * height, target_y))
		}
		mp_linear_step_object(target_x, target_y, 10, oCameraBlock)

		/*if camerawork_time < camerawork_period {
			var camerawork_ratio = ease_out_quartic(camerawork_time / camerawork_period)
			x = lerp(camerawork_coordinate_begin[0], target_x, camerawork_ratio)
			y = lerp(camerawork_coordinate_begin[1], target_y, camerawork_ratio)

			camerawork_time++

			if camerawork_period <= camerawork_time
				camerawork_status = CLEARING
		} else {
			if camerawork_status == CLEARING {
				camerawork_time = camerawork_period
				x = target_x
				y = target_y
				camerawork_status = NORMAL
			} else {
				mp_linear_step_object(target_x, target_y, 10, oCameraBlock)
			}
		}*/
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
		target_x += target.x
		target_y += target.y
		if instance_exists(area) {
			target_x = max(area.bbox_left + anchor_x * width, min(area.bbox_right - (1 - anchor_x) * width, target_x))
			target_y = max(area.bbox_top + anchor_y * height, min(area.bbox_bottom - (1 - anchor_y) * height, target_y))
		}

		if camerawork_time < camerawork_transition_period {
			var camerawork_ratio = ease_out_quartic(camerawork_time / camerawork_transition_period)
			x = lerp(camerawork_coordinate_begin[0], target_x, camerawork_ratio)
			y = lerp(camerawork_coordinate_begin[1], target_y, camerawork_ratio)

			camerawork_time++

			if camerawork_transition_period <= camerawork_time
				camerawork_status = CLEARING
		} else {
			if camerawork_status == CLEARING {
				camerawork_time = camerawork_transition_period
				x = target_x
				y = target_y
				camerawork_status = NORMAL
				mode = camera_mode.dynamic

				instance_deactivate_all(true)
				instance_activate_object(oIgnore)
				instance_activate_object(oPlayer)
				instance_activate_object(oLightObject)
				instance_activate_region(bbox_left, bbox_top, bbox_right, bbox_bottom, true)
			}
		}
		#endregion
	break

	default:
	break
}


