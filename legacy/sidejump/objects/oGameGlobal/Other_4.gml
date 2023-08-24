/// @description 배경 레이어에 빛나는 효과 추가
// Backgrounds_Tiles
var glower_bg_id = layer_get_id("Backgrounds_Tiles")
layer_script_begin(glower_bg_id, player_glow_begin)
layer_script_end(glower_bg_id, player_glow_end)

glower_bg_id = layer_get_id("Backgrounds_Tiles_Above")
layer_script_begin(glower_bg_id, player_glow_begin)
layer_script_end(glower_bg_id, player_glow_end)
