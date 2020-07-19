/// @description player_jump_once(velocity)
/// @function player_jump_once
/// @param velocity { real }
function player_jump_once(argument0) {
	jumping = true
	velocity_y = argument0
	audio_play_sound(soundJump,	1, false)



}
