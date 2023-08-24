/// @param [data]
function List(data = undefined) constructor
{
	myData = undefined
	mySize = int64(0)
	myCapacity = int64(0)
	
	/// @self List
	/// @param {Struct.List} list
	/// @desc checked dynamic enumerator [off, guard)
	static ListEnumerator = function(list) constructor
	{
		myListID = list
		myOffset = 0
		myValue = undefined

		/// @self ListEnumerator
		/// @param {Struct.ListEnumerator} obj
		/// @return {Bool}
		/// @pure
		static Compare = function(obj)
		{
			if not is_instanceof(obj, List.ListEnumerator)
			{
				return false
			}

			return obj.myListID == myListID and obj.myOffset == myOffset
		}

		/// @self ListEnumerator
		/// @return {Bool}
		static Next = function()
		{
			if 0 < myListID.mySize and myOffset < myListID.mySize - 1
			{
				myValue = myListID.myData[myOffset++]

				return true
			}
			
			return false
		}

		/// @self ListEnumerator
		/// @return {Any}
		/// @pure
		static Get = function()
		{
			return myValue
		}
	}

	/// @self List
	/// @param {Struct.List} list
	/// @desc unchecked static enumerator
	static ListIterator = function(list) constructor
	{
		myListID = list
		myOffset = 0
		myGuard = list.mySize

		/// @self ListIterator
		/// @param {Struct.ListIterator} obj
		/// @return {Bool}
		static Compare = function(obj)
		{
			if not is_instanceof(obj, List.ListIterator)
			{
				return false
			}

			return obj.myListID == myListID and obj.myOffset == myOffset and obj.myGuard == myGuard
		}

		/// @self ListIterator
		/// @return {Real}
		static Forward = function()
		{
			return myOffset++
		}

		/// @self ListIterator
		/// @return {Bool}
		static Next = function()
		{
			if myOffset < myGuard - 1
			{
				++myOffset
				return true
			}
			
			return false
		}

		/// @self ListIterator
		/// @return {Any}
		/// @pure
		static Get = function()
		{
			return myListID.myData[myOffset]
		}
		
		/// @self ListIterator
		/// @param {Array} result
		/// @return {Bool}
		/// @pure
		static TryGet = function(result)
		{
			if myOffset < myListID.mySize
			{
				result[0] = myListID.myData[myOffset]
				return true
			}

			return false
		}
	}

	/// @self List
	/// @param {Any} value
	static Push = function(value)
	{
		if (mySize < myCapacity)
		{
			myData[mySize] = value
		}
		else
		{
			array_push(myData, value);
			myCapacity++
		}

		mySize++
	}

	/// @self List
	/// @param {Struct.ListEnumerator} enumerator
	static AssignBy = function(enumerator)
	{
		var index = 0

		while (enumerator.Next())
		{
			myData[index++] = enumerator.Get()
		}
	}
	
	/// @self List
	/// @param {Struct.ListIterator} it
	/// @param {Struct.ListIterator} sentinel
	static Assign = function(it, sentinel)
	{
		var index = 0
		while (not it.Compare(sentinel))
		{
			myData[index++] = it.Get()
			it.Forward()
		}
	}

	/// @self List
	/// @param {Struct.ListIterator} it
	/// @param {Struct.ListIterator} sentinel
	/// @param {Function} [predicate] function(value)
	static Generate = function(it, sentinel, predicate = function(value) { return value; })
	{
		var index = 0

		while (not it.Compare(sentinel))
		{
			myData[index++] = predicate(it.Get())

			it.Forward()
		}
	}

	/// @self List
	/// @param {Struct.ListIterator} it
	/// @param {Struct.ListIterator} sentinel
	/// @param {Function} predicate function(value)
	static ForEach = function(it, sentinel, predicate)
	{
		while (not it.Compare(sentinel))
		{
			predicate(it.Get())

			it.Forward()
		}
	}

	/// @self List
	/// @param {Function} predicate function(value, index)
	static Enumerate = function(predicate)
	{
		array_foreach(myData, predicate)
	}

	/// @self List
	/// @param {Real} index
	/// @pure
	static At = function(index)
	{
		return myData[index]
	}

	/// @self List
	/// @return {Real}
	/// @pure
	static GetSize = function()
	{
		return mySize
	}

	/// @self List
	/// @param {Real} size
	/// @return {Undefined}
	/// @ignore
	static _Construct = function(size)
	{
		if 0 < size
		{
			myData = array_create(size)
			mySize = 0
			myCapacity = size
		}
	}

	/// @self List
	/// @param {Array} array
	/// @param {Real} size
	/// @return {Undefined}
	/// @ignore
	static _ConstructFromSizedArray = function(array, size)
	{
		_Construct(size)
		mySize = size

		array_copy(myData, 0, array, 0, size)
	}

	/// @self List
	/// @param {Array} array
	/// @return {Undefined}
	/// @ignore
	static _ConstructFromArray = function(array)
	{
		var size = array_length(array)
		if 0 < size
		{
			_ConstructFromSizedArray(array, size)
		}
		else
		{
			show_error($"Cannot create data from empty array! ({ self })", true)
		}
	}

	/// @self List
	/// @param {ID.DsList} list
	/// @return {Undefined}
	/// @ignore
	static _ConstructFromList = function(list)
	{
		var size = ds_list_size(list)
		if 0 < size
		{
			_Construct(size)
			mySize = size

			for (var i = 0; i < size; ++i)
			{
				myData[i] = ds_list_find_value(list, i)
			}
		}
		else
		{
			show_error($"Cannot create data from empty list { list }! ({ self })", true)
		}
	}

	/// @self List
	/// @param {Struct.List} list
	/// @return {Undefined}
	/// @ignore
	static _ConstructFromOther = function(list)
	{
		var size = list.mySize
		if 0 < size
		{
			_ConstructFromArray(list.myData)
		}
		else
		{
			show_error($"Cannot create data from empty list { list }! ({ self })", true)
		}
	}

	/// @self List
	/// @param {Array} array
	/// @return {Undefined}
	/// @ignore
	static _CopyFromArray = function(array)
	{
		var size = array_length(array);
		if 0 < array_length(array)
		{
			if (myCapacity < size)
			{
				if (is_array(myData))
				{
					//delete myData
				}

				_ConstructFromArray(array)
			}
			else
			{
				array_copy(myData, 0, array, 0, size)
				mySize = max(size, mySize)
			}
		}
		else
		{
			show_error($"Cannot dereference the empty array! ({ self })", true)
		}
	}

	// ** Contructor **
	if 0 < argument_count
	{
		if 1 == argument_count
		{
			if is_array(data) 
			{
				// (*) Built-in Array
				_ConstructFromArray(data)
			}
			else if !is_nan(data) and ds_exists(data, ds_type_list)
			{
				// (*) Built-in List
				_ConstructFromList(data)
			}
			else if is_struct(data)
			{
				if is_instanceof(data, List)
				{
					// (*) Container
					_ConstructFromOther(data)
				}
				else if is_instanceof(argument[0], List.ListEnumerator)
				{
					// (*) ListEnumerator
					AssignBy(argument[0])
				}
			}
			else
			{
				show_error($"Cannot create list! ({ self })", true)
			}
		}
		else if argument_count == 2
		{
			if is_struct(argument[0]) and is_instanceof(argument[0], List.ListIterator)
				and is_struct(argument[1]) and is_instanceof(argument[1], List.ListIterator)
			{
				// (*) Begin, End
				Assign(argument[0], argument[1])
			}
			else
			{
				// (*) Value0, Value1
				_Construct(2)
				for (var i = 0; i < 2; ++i)
				{
					myData[i] = argument[i];
				}
			}
		}
		else if 2 < argument_count
		{
			// (*) Value0, Value1, ...
			_Construct(argument_count)
			for (var i = 0; i < argument_count; ++i)
			{
				myData[i] = argument[i];
			}
		}
	}
}