/// @description player_preserve_hspeed([duration])
/// @function player_preserve_hspeed
/// @param [duration] { real }
function player_preserve_hspeed() {
	movement_preserve_velocity = velocity_x
	if 0 < argument_count
		movement_preserve_time = argument[0]
	else
		movement_preserve_time = movement_preserve_period



}
