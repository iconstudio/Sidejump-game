/// @description 카메라 이동
switch mode {
	case camera_mode.dynamic:
		#region dynamic
		if !instance_exists(target)
			exit

		switch postition {
			case camera_position.left_up:
				camerawork_coordinate_target[0] = target.x - width * 0.5 + border
				camerawork_coordinate_target[1] = target.y - height * 0.5 + border
			break

			case camera_position.left_middle:
				camerawork_coordinate_target[0] = target.x - width * 0.5 + border
				camerawork_coordinate_target[1] = target.y
			break

			case camera_position.left_down:
				camerawork_coordinate_target[0] = target.x - width * 0.5 + border
				camerawork_coordinate_target[1] = target.y + height * 0.5 - border
			break

			case camera_position.center_up:
				camerawork_coordinate_target[0] = target.x
				camerawork_coordinate_target[1] = target.y - height * 0.5 + border
			break

			case camera_position.center_middle:
				camerawork_coordinate_target[0] = target.x
				camerawork_coordinate_target[1] = target.y
			break

			case camera_position.center_down:
				camerawork_coordinate_target[0] = target.x
				camerawork_coordinate_target[1] = target.y + height * 0.5 - border
			break

			case camera_position.right_up:
				camerawork_coordinate_target[0] = target.x + width * 0.5 - border
				camerawork_coordinate_target[1] = target.y - height * 0.5 + border
			break

			case camera_position.right_middle:
				camerawork_coordinate_target[0] = target.x + width * 0.5 - border
				camerawork_coordinate_target[1] = target.y
			break

			case camera_position.right_down:
				camerawork_coordinate_target[0] = target.x + width * 0.5 - border
				camerawork_coordinate_target[1] = target.y + height * 0.5 - border
			break

			default:
			break
		}
		
		if camerawork_time < camerawork_period {
			var camerawork_ratio = ease_out_quartic(camerawork_time / camerawork_period)
			x = lerp(camerawork_coordinate_begin[0], camerawork_coordinate_target[0], camerawork_ratio)
			y = lerp(camerawork_coordinate_begin[1], camerawork_coordinate_target[1], camerawork_ratio)

			camerawork_time++

			if camerawork_period <= camerawork_time
				camerawork_status = CLEARING
		} else {
			if camerawork_status == CLEARING {
				camerawork_time = camerawork_period
				x = camerawork_coordinate_target[0]
				y = camerawork_coordinate_target[1]
				camerawork_status = END
			} else {
				var target_x = camerawork_coordinate_target[0]
				var target_y = camerawork_coordinate_target[1]
				var distance_x = target_x - x
				var distance_y = target_y - y
				

				//mp_linear_step_object(target_x, target_y, 10, oCameraBlock)
			}
		}
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

	case camera_mode.transition_horizontal:
		#region transition_horizontal
		repeat camerawork_transition_horizontal_velocity {
			if instance_place(x, y, oCameraBlock) or instance_place(x + camerawork_transition_direction[0], y, oCameraBlock) {
				x += camerawork_transition_direction[0]
			} else {
				mode = camera_mode.dynamic
				break
			}
		}
		#endregion
	break

	case camera_mode.transition_vertical:
		#region transition_vertical
		repeat camerawork_transition_vertical_velocity {
			if instance_place(x, y, oCameraBlock) or instance_place(x, y + camerawork_transition_direction[1], oCameraBlock) {
				y += camerawork_transition_direction[1]
			} else {
				mode = camera_mode.dynamic
				break
			}
		}
		#endregion
	break

	default:
	break
}
