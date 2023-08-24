/// @description player_prohibit_moving([duration])
/// @function player_prohibit_moving
/// @param [duration] { real }
if 0 < argument_count
	movement_forbid_time = argument[0]
else
	movement_forbid_time = movement_forbid_period
