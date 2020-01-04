/// @description player_preserve_hspeed([velocity])
/// @function player_preserve_hspeed
/// @param [velocity] { real }
if 0 < argument_count
	movement_preserve_velocity = abs(argument[0])
else
	movement_preserve_velocity = abs(velocity_x)
movement_preserve_time = movement_preserve_period
