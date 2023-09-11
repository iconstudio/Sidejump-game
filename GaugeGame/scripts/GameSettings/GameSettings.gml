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
			var json = new JsonReader(settingFile)
			var data = json.myData

			var mus_vol = 0.7
			var raw_mus_vol = data[$ "mus_volume"]
			if is_real(raw_mus_vol)
			{
				mus_vol = raw_mus_vol
			}
			else if not is_undefined(raw_mus_vol)
			{
				mus_vol = real(raw_mus_vol)
			}
			musVolume = mus_vol

			var sfx_vol = 1.0
			var raw_sfx_vol = data[$ "sfx_volume"]
			if is_real(raw_sfx_vol)
			{
				sfx_vol = raw_sfx_vol
			}
			else if not is_undefined(raw_sfx_vol)
			{
				sfx_vol = real(raw_sfx_vol)
			}
			sfxVolume = sfx_vol

			delete json
		}
		catch (e)
		{
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
			throw "Cannot open the setting fie"
		}

		txt.Write(json)

		txt.Close()
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
