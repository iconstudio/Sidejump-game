/// @description 카메라 이동
switch camera.mode {
	case camera_mode.dynamic:
		#region dynamic
		if !instance_exists(camera.target)
			exit

		switch camera.postition {
			case camera_position.left_up:
				camerawork_coordinate_target[0] = camera.target.x - camera.width * 0.5 + camera.border
				camerawork_coordinate_target[1] = camera.target.y - camera.height * 0.5 + camera.border
			break

			case camera_position.left_middle:
				camerawork_coordinate_target[0] = camera.target.x - camera.width * 0.5 + camera.border
				camerawork_coordinate_target[1] = camera.target.y
			break

			case camera_position.left_down:
				camerawork_coordinate_target[0] = camera.target.x - camera.width * 0.5 + camera.border
				camerawork_coordinate_target[1] = camera.target.y + camera.height * 0.5 - camera.border
			break

			case camera_position.center_up:
				camerawork_coordinate_target[0] = camera.target.x
				camerawork_coordinate_target[1] = camera.target.y - camera.height * 0.5 + camera.border
			break

			case camera_position.center_middle:
				camerawork_coordinate_target[0] = camera.target.x
				camerawork_coordinate_target[1] = camera.target.y
			break

			case camera_position.center_down:
				camerawork_coordinate_target[0] = camera.target.x
				camerawork_coordinate_target[1] = camera.target.y + camera.height * 0.5 - camera.border
			break

			case camera_position.right_up:
				camerawork_coordinate_target[0] = camera.target.x + camera.width * 0.5 - camera.border
				camerawork_coordinate_target[1] = camera.target.y - camera.height * 0.5 + camera.border
			break

			case camera_position.right_middle:
				camerawork_coordinate_target[0] = camera.target.x + camera.width * 0.5 - camera.border
				camerawork_coordinate_target[1] = camera.target.y
			break

			case camera_position.right_down:
				camerawork_coordinate_target[0] = camera.target.x + camera.width * 0.5 - camera.border
				camerawork_coordinate_target[1] = camera.target.y + camera.height * 0.5 - camera.border
			break

			default:
			break
		}
		
		if camerawork_time < camerawork_period {
			var camerawork_ratio = ease_out_quartic(camerawork_time / camerawork_period)
			camera.x = lerp(camerawork_coordinate_begin[0], camerawork_coordinate_target[0], camerawork_ratio)
			camera.y = lerp(camerawork_coordinate_begin[1], camerawork_coordinate_target[1], camerawork_ratio)

			camerawork_time++

			if camerawork_period <= camerawork_time
				camerawork_status = CLEARING
		} else {
			if camerawork_status == CLEARING {
				camerawork_time = camerawork_period
				camera.x = camerawork_coordinate_target[0]
				camera.y = camerawork_coordinate_target[1]
				camerawork_status = END
			} else {
				var target_x = camerawork_coordinate_target[0]
				var target_y = camerawork_coordinate_target[1]
				//camera.x = target_x
				//camera.y = target_y

				with camera {
					/*if target_x != x {
						var sign_x = target_x - x
						var check_x = sign_x < 0 ? x - xspeed - 1 : x + xspeed + 1
						if instance_place(check_x, y, oCameraBlock) {
							if sign_x < 0 {
								repeat xspeed + 1 {
									//instance_place(x - 1, y, oCameraBlock)
									if 0 < collision_line(bbox_left - 1, bbox_top, bbox_left - 1, bbox_bottom, oCameraBlock, false, true)
										break
									x--
								}
							} else {
								repeat xspeed + 1 {
									if 0 < collision_line(bbox_right + 1, bbox_top, bbox_right + 1, bbox_bottom, oCameraBlock, false, true)
										break
									x++
								}
							}
						} else {
							if abs(sign_x) < xspeed
								x = target_x
							else
								x += xspeed * sign(sign_x)
						}
					}

					if target_y != y {
						var sign_y = target_y - y
						var check_y = sign_y < 0 ? y - yspeed - 1 : y + yspeed + 1
						if instance_place(x, check_y, oCameraBlock) {
							if check_y < 0 {
								repeat yspeed + 1 {
									if 0 < collision_line(bbox_left, bbox_top - 1, bbox_right, bbox_top - 1, oCameraBlock, false, true)
										break
									y--
								}
							} else {
								repeat yspeed + 1 {
									if 0 < collision_line(bbox_left, bbox_bottom + 1, bbox_right, bbox_bottom + 1, oCameraBlock, false, true)
										break
									y++
								}
							}
						} else {
							if abs(sign_y) < yspeed
								y = target_y
							else
								y += yspeed * sign(sign_y)
						}
					}
					*/
					mp_linear_step_object(target_x, target_y, 10, oCameraBlock)
				}
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
		with camera {
			if instance_place(x, y, oCameraBlock) {
				if transition == camera_transition.left
					x -= other.camerawork_transition_horizontal_velocity
				else if transition == camera_transition.right
					x += other.camerawork_transition_horizontal_velocity
			} else {
				transition = camera_mode.dynamic
			}
		}
		#endregion
	break

	case camera_mode.transition_vertical:
		#region transition_vertical
		#endregion
	break

	default:
	break
}
