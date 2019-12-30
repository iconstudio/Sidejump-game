/// @description 카메라 이동
if !instance_exists(target) and (mode != camera_mode.fixed and mode != camera_mode.fixed)
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

switch mode {
	case camera_mode.dynamic:
		#region dynamic
		target_x += target.x
		target_y += target.y

		if camerawork_time < camerawork_period {
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
				camerawork_status = END
			} else {
				mp_linear_step_object(target_x, target_y, 30, oCameraBlock)
				//x = target_x
				//y = target_y
				//var distance_x = target_x - x, sign_x = sign(distance_x)
				//var distance_y = target_y - y, sign_y = sign(distance_y)
				//var check_x = false, check_y = false

				/*
				repeat 20 {
					if distance_x < 0
						check_x = 0 < collision_line(bbox_left - 1, bbox_top + 1, bbox_left - 1, bbox_bottom - 1, oCameraBlock, false, true)
					else if 0 < distance_x
						check_x = 0 < collision_line(bbox_right + 1, bbox_top + 1, bbox_right + 1, bbox_bottom - 1, oCameraBlock, false, true)

					if distance_y < 0
						check_y = 0 < collision_line(bbox_left + 1, bbox_top - 1, bbox_right - 1, bbox_top - 1, oCameraBlock, false, true)
					else if 0 < distance_y
						check_y = 0 < collision_line(bbox_left + 1, bbox_bottom + 1, bbox_right - 1, bbox_bottom + 1, oCameraBlock, false, true)

					if !check_x and !check_y {
						move_towards_point(target_x, target_y, 1)
					} else if !check_x {
						if abs(distance_x) <= 1
							x = target_x
						else
							x += sign_x
					} else if !check_y {
						if abs(distance_y) <= 1
							y = target_y
						else
							y += sign_y
					} else {
						break
					}
					//mp_potential_step_object(target_x, target_y, 1, oCameraBlock)
				}//*/
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

	case camera_mode.transition_area:
		#region transitioning
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

	default:
	break
}
