/// @description Initialize the display
gameDisplay.appWidth = window_get_width()
gameDisplay.appHeight = window_get_height()
gameDisplay.osWidth = display_get_width()
gameDisplay.osHeight = display_get_height()
gameDisplay.appAspectRatio = window_get_height() / window_get_width()

//display_set_gui_size(gameDisplay.appWidth, gameDisplay.appHeight)
//var gui_width = display_get_gui_width()
//var gui_height = display_get_gui_height()

if (audioLoaded)
{
	alarm[1] = 1
}
