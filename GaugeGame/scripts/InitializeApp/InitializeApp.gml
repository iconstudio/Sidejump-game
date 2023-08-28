function InitializeApp()
{
	globalvar gamePlatform, gameDisplay, gameUnit, gameSetting, gameInput;

	gamePlatform = new GamePlatform()
	gamePlatform.isDesktop = (os_type == os_windows or os_type == os_macosx or os_type == os_linux)
	gamePlatform.isMobile = (os_type == os_android or os_type == os_ios)
	gamePlatform.isBrowser = (os_browser != browser_not_a_browser)

	gameDisplay = new GameDisplay()

	gameSetting = new GameSetting(18)
	gameSetting.UpdateTimes()
	gameSetting.UpdateUnits()

	gameInput = new GameInputs()
	

	if (_DEBUG_)
	{
		show_debug_log(true)
		gml_release_mode(false)
	}
	else 
	{
		gml_release_mode(true)
	}

	application_surface_enable(true)
	application_surface_draw_enable(true)

	surface_depth_disable(true)
	display_reset(0, false)

	window_set_cursor(cr_none)
	device_mouse_dbclick_enable(false)

	if gamePlatform.isBrowser
	{
		window_set_fullscreen(true)
		display_set_sleep_margin(4)
		audio_channel_num(4)
		os_powersave_enable(false)
	}
	else if gamePlatform.isMobile
	{
		display_set_sleep_margin(30)
		audio_channel_num(16)
	}
	else 
	{
		display_set_sleep_margin(10)
		audio_channel_num(32)
	}
}