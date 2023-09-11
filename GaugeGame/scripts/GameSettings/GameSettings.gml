function GameSettings() constructor
{
	masterVolume = 1.0
	musVolume = 0.7
	sfxVolume = 1.0
	prevMasterVolume = 1.0
	prevMusVolume = 1.0
	prevSfxVolume = 1.0
	isSfxMuted = false
	isMusMuted = false

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
		var saver =
		{
			mus_volume : musVolume,
			sfx_volume : sfxVolume,
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
			isSfxMuted = false
		}
		else
		{
			prevSfxVolume = 0.1
			isSfxMuted = true
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
		if not isSfxMuted
		{
			prevSfxVolume = sfxVolume
			sfxVolume = 0.0
			isSfxMuted = true
		}
		
	}

	/// @self GameSettings
	static UnmuteSfx = function()
	{
		if isSfxMuted
		{
			sfxVolume = prevSfxVolume
			isSfxMuted = false
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
			isMusMuted = false
		}
		else
		{
			prevMusVolume = 0.1
			isMusMuted = true
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
		if not isMusMuted
		{
			prevMusVolume = musVolume
			musVolume = 0.0
			isMusMuted = true
		}
		
	}

	/// @self GameSettings
	static UnmuteMusic = function()
	{
		if isMusMuted
		{
			musVolume = prevMusVolume
			isMusMuted = false
		}
	}
}
