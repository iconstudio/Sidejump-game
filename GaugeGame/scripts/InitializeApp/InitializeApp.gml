function InitializeApp()
{
	globalvar gamePlatform, gameDisplay, gameSetting, gameUnit, gameInput;

	gamePlatform = new GamePlatform()
	gamePlatform.isDesktop = (os_type == os_windows or os_type == os_macosx or os_type == os_linux)
	gamePlatform.isMobile = (os_type == os_android or os_type == os_ios)
	gamePlatform.isBrowser = (os_browser != browser_not_a_browser)

	gameDisplay = new GameDisplay()

	gameSetting = new GameSettings()
	gameSetting.Load()

	gameUnit = new GameUnit(18)
	gameUnit.UpdateTimes()
	gameUnit.UpdateUnits()

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


	if gamePlatform.isBrowser
	{
		window_center()
		window_set_fullscreen(true)
		display_set_sleep_margin(4)
		audio_channel_num(4)
		os_powersave_enable(false)
		window_set_cursor(cr_none)
	}
	else if gamePlatform.isMobile
	{
		display_set_sleep_margin(30)
		audio_channel_num(16)
		os_powersave_enable(true)
		window_set_cursor(cr_none)
	}
	else 
	{
		window_center()
		display_set_sleep_margin(10)
		audio_channel_num(32)
		window_set_cursor(cr_none)
	}

	device_mouse_dbclick_enable(false)

	randomize()
}