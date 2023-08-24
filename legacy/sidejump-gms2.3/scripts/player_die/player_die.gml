/// @description player_die()
/// @function player_die
function player_die() {
	instance_destroy(oPlayer)

	with oGameGlobal
		alarm[0] = seconds(2)



}
