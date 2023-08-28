function GameInputs() constructor
{
	myMap = new Map()
	virtualIOs = new List()

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

		virtualIOs.Enumerate(__Update)
	}
}
