/// @param {Real} vx
/// @param {Real} vy
function Vector2(vx = 0, vy = 0) constructor
{
	self.x = vx
	self.y = vy

	/// @self Vector2
	/// @return {Real}
	/// @pure
	static GetAbsolute = function()
	{
		return point_distance(0, 0, self.x, self.y)
	}

	/// @self Vector2
	/// @return {Real}
	/// @pure
	static GetLength = function()
	{
		return self.GetAbsolute()
	}

	/// @self Vector2
	/// @return {Struct.Vector2}
	/// @pure
	static GetUnit = function()
	{
		var len = self.GetLength()

		return new Vector2(self.x / len, self.y / len)
	}
}
