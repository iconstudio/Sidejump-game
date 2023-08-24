/// @description player_prohibit_jumping([duration])
/// @function player_prohibit_jumping
/// @param [duration] { real }
function player_prohibit_jumping() {
	if 0 < argument_count
		jump_forbid_time = argument[0]
	else
		jump_forbid_time = jump_forbid_period



}
