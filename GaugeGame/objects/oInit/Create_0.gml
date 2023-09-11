/// @description Initialize the game
#macro _DEBUG_ true
#macro Release:_DEBUG_ false

audioLoaded = false

gml_pragma("global", "InitializeApp()")

var audios = audio_group_get_assets(audioEverything)
if (0 == array_length(audios))
{
	audioLoaded = true
	alarm[0] = 1

	exit
}

if !audio_group_is_loaded(audioEverything)
{
	audio_group_load(audioEverything)
}
else
{
	audioLoaded = true
	alarm[0] = 1
}
