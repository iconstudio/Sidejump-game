/// @param {Array<Struct.Pair>, Array<Array>} values
function Map(values = [[]]) constructor
{
	myData = {}
	mySize = 0

	/// @self Map
	/// @param {String} key
	/// @param {Any} value
	static Add = function(key, value)
	{
		if not struct_exists(myData, key)
		{
			mySize++
		}

		struct_set(myData, key, value)
		return self
	}

	/// @self Map
	/// @param {String} key
	/// @param {Any} value
	/// @return {Bool}
	static TryAdd = function(key, value)
	{
		if not struct_exists(myData, key)
		{
			Add(key, value)
			return true
		}
		else
		{
			return false
		}
	}

	/// @self Map
	/// @param {String} key
	/// @param {Any} value
	static Set = function(key, value)
	{
		if not struct_exists(myData, key)
		{
			mySize++
		}

		struct_set(myData, key, value)
	}
	
	
	/// @self Map
	/// @param {String} key
	/// @return {Bool}
	static Delete = function(key)
	{
		if Contains(key)
		{
			struct_remove(myData, key)

			return true
		}
		else
		{
			return false
		}
	}

	/// @self Map
	/// @param {String} key
	/// @return {Any}
	/// @pure
	static Get = function(key)
	{
		return struct_get(myData, key)
	}

	/// @self Map
	/// @param {String} key
	/// @return {Bool}
	/// @pure
	static Contains = function(key)
	{
		return struct_exists(myData, key)
	}

	/// @self Map
	/// @param {String} key
	/// @return {Bool}
	/// @pure
	static Exists = function(key)
	{
		return struct_exists(myData, key)
	}

	if is_array(values)
	{
		var ctor_length = array_length(values)

		if 0 < ctor_length
		{
			for (var i = 0; i < ctor_length; i++)
			{
				var item = array_get(values, i)

				if is_array(item)
				{
					var item_len = array_length(item)
					if 2 == item_len
					{
						var item_name = item[0]
						if not is_string(item_name)
						{
							throw $"Cannot make a map pair from the non-string key ({ string(item_name) })"
						}

						Add(item_name, item[1])
					}
					else if 2 < item_len
					{
						throw $"Cannot make a map pair from the array with invalid length ({ item_len })"
					}
				}
				else if is_struct(item) and is_instanceof(item, Pair)
				{
					Add(item.myLhs, item.myRhs)
				}
			}
		}
	}
}
