/// @param {Real} meter
function GameSetting(meter) constructor
{
	// Time Units
	stepsPerSecond = 0
	secondsPerStep = 0

	// Space Units
	meterToPixel = meter
	pixelPerStep = 1 // a arbitrary value

	// Physics Constants
	rawGravity = 10
	worldGravity = 10

	// Terrain
	// Chunk
	horzTiles = 10
	vertTiles = 8

	// Room Size
	horzChunks = 3
	vertChunks = 3

	/// @self GameSetting
	/// @desc convert [km/h] to [pixel/step]
	/// @param {Real} value
	/// @return {Real}
	/// @pure
	static CalcVelocity = function(value)
	{
		return value * pixelPerStep
	}

	/// @self GameSetting
	/// @param {Real} value
	/// @return {Real}
	/// @pure
	static Seconds = function(value)
	{
		return value * stepsPerSecond
	}

	/// @self GameSetting
	/// @param {Real} value
	/// @return {Real}
	/// @pure
	static Meters = function(value)
	{
		return value * meterToPixel
	}

	/// @self GameSetting
	/// @desc Update space units.
	/// @return {Undefined}
	static UpdateUnits = function()
	{
		var mess = 1000.0 * meterToPixel / 3600.0

		pixelPerStep = mess * secondsPerStep

		worldGravity = 9.8
	}

	/// @self GameSetting
	/// @desc Update time units.
	/// @return {Undefined}
	static UpdateTimes = function()
	{
		stepsPerSecond = game_get_speed(gamespeed_fps)
		secondsPerStep = 1 / stepsPerSecond
	}
}