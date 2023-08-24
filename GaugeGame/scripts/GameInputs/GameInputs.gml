function GameInputs() constructor
{
	myMap = new List()

	/// @self GameInputs
	/// @func Update
	/// @return {Undefined}
	static Update = function()
	{
		/// @self GameInputs
		/// @param {Struct.InputIndicator} indicator 
		/// @param {Real} index 
		/// @return {Undefined}
		/// @ignore
		static __Update = function(indicator, index)
		{
			indicator.Update()
		}

		myMap.Enumerate(__Update)
	}
}
