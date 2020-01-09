/// @description player_glow_begin()
/// @function player_glow_begin
if event_type == ev_draw and event_number == 0 {
	var player_position = shader_get_uniform(shaderPlayerGlow, "player_position")
	shader_set(shaderPlayerGlow)
	if instance_exists(oPlayer)
		shader_set_uniform_f(player_position, oPlayer.x, oPlayer.y, 0, 0)
	else
		shader_set_uniform_f(player_position, -1, -1, -1, 0)
}
