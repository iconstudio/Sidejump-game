function GameSettings() constructor
{
	masterVolume = 1.0
	musVolume = 0.7
	sfxVolume = 1.0
	windowMode = GameWindowMode.Windowed
	stayAwake = false

	__prevMasterVolume = 1.0
	__prevMusVolume = 1.0
	__prevSfxVolume = 1.0
	__isSfxMuted = false
	__isMusMuted = false

	settingFile = "settings.gauge"
	tilesetRef = "test/Everything.tsx"

	/// @self GameSettings
	static Load = function()
	{
		try
		{
			show_debug_message("Loading the setting file")

			var json = new JsonReader(settingFile)
			var data = json.myData

			show_debug_message("Successfully loaded the setting file")

			musVolume = Read(data, "mus_volume", ty_real, 0.7)
			sfxVolume = Read(data, "sfx_volume", ty_real, 1.0)

			var window_mode = string_lower(Read(data, "window_mode", ty_string, "Windowed"))
			if window_mode == "borderless"
			{
				windowMode = GameWindowMode.BordelessWindow
			}
			else if window_mode == "fullscreen"
			{
				windowMode = GameWindowMode.Fullscreen
			}
			else
			{
				windowMode = GameWindowMode.Windowed
			}
			ApplyWindowMode()

			stayAwake = bool(Read(data, "powersave", ty_real, 1))
			ApplyPowersave()

			delete json
		}
		catch (e)
		{
			show_debug_message("Failed to load the setting file")
			Save()
		}
	}

	/// @self GameSettings
	static Save = function()
	{
		var make_wmd = (windowMode == GameWindowMode.Fullscreen) ? "Fullscreen" : ((windowMode == GameWindowMode.BordelessWindow) ? "Borderless" : "Windowed")

		var saver =
		{
			mus_volume : musVolume,
			sfx_volume : sfxVolume,
			window_mode : make_wmd,
			powersave : real(stayAwake),
		}

		var json = json_stringify(saver, true)
		var txt = new WritableTextFile(settingFile, true)
		if not txt.IsValid()
		{
			show_debug_message("Cannot open the setting file")

			return false
		}

		txt.Write(json)

		txt.Close()
		delete txt

		return true
	}

	/// @self GameSettings
	/// @param {Any} json_data
	/// @param {String} value_name
	/// @param {Constant.ExternalArgumentType} value_type
	/// @param {Any} default_value
	/// @return {Any}
	static Read = function(json_data, value_name, value_type, default_value)
	{
		var result = json_data[$ value_name]
		if is_undefined(result)
		{
			return default_value
		}
		else
		{
			if ty_real == value_type
			{
				if is_real(result)
				{
					return result
				}
				else
				{
					return real(result)
				}
			}
			else
			{
				if is_string(result)
				{
					return result
				}
				else
				{
					return string(result)
				}
			}
		}
	}

	/// @self GameSettings
	/// @param {Real} volume
	/// @return {Real}
	static SetSfxVolume = function(volume)
	{
		var vol = sfxVolume

		if 0 < volume
		{
			__isSfxMuted = false
		}
		else
		{
			__prevSfxVolume = 0.1
			__isSfxMuted = true
		}
		sfxVolume = volume

		return vol
	}

	/// @self GameSettings
	/// @return {Real}
	/// @pure
	static GetSfxVolume = function()
	{
		return sfxVolume
	}

	/// @self GameSettings
	static MuteSfx = function()
	{
		if not __isSfxMuted
		{
			__prevSfxVolume = sfxVolume
			sfxVolume = 0.0
			__isSfxMuted = true
		}
		
	}

	/// @self GameSettings
	static UnmuteSfx = function()
	{
		if __isSfxMuted
		{
			sfxVolume = __prevSfxVolume
			__isSfxMuted = false
		}
	}

	/// @self GameSettings
	/// @param {Real} volume
	/// @return {Real}
	static SetMusicVolume = function(volume)
	{
		var vol = musVolume

		if 0 < volume
		{
			__isMusMuted = false
		}
		else
		{
			__prevMusVolume = 0.1
			__isMusMuted = true
		}
		musVolume = volume

		return vol
	}

	/// @self GameSettings
	/// @return {Real}
	/// @pure
	static GetMusicVolume = function()
	{
		return musVolume
	}

	/// @self GameSettings
	static MuteMusic = function()
	{
		if not __isMusMuted
		{
			__prevMusVolume = musVolume
			musVolume = 0.0
			__isMusMuted = true
		}
		
	}

	/// @self GameSettings
	static UnmuteMusic = function()
	{
		if __isMusMuted
		{
			musVolume = __prevMusVolume
			__isMusMuted = false
		}
	}

	/// @self GameSettings
	static ApplyWindowMode = function()
	{
		if gamePlatform.isDesktop
		{
			switch windowMode
			{
				case GameWindowMode.Windowed:
				{
					window_set_fullscreen(false)
					window_set_showborder(true)
				}
				break

				case GameWindowMode.BordelessWindow:
				{
					window_set_fullscreen(false)
					window_set_showborder(false)
				}
				break

				case GameWindowMode.Fullscreen:
				{
					window_set_fullscreen(true)
				}
				break
			}
		}
	}

	/// @self GameSettings
	static ApplyPowersave = function()
	{
		os_powersave_enable(stayAwake)
	}
}
