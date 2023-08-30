/// @param {String} default_state
function StateMachine(default_state = "stateEmpty") constructor
{
	myStatus = default_state
	myStates = new Map([[default_state, false]])

	/// @self StateMachine
	/// @param {String} state
	static Add = function(state)
	{
		myStates.Add(state, false)
	}

	/// @self StateMachine
	/// @param {String} state
	/// @return {Bool}
	static Set = function(state)
	{
		if myStates.Contains(state)
		{
			if myStatus != state and true == myStates.Get(myStatus)
			{
				return false
			}
			else
			{
				myStatus = state
				return true
			}
		}
		else
		{
			return false
		}
	}

	/// @self StateMachine
	static Lock = function()
	{
		if myStates.Contains(myStatus)
		{
			myStates.Set(myStatus, true)
		}
	}

	/// @self StateMachine
	static Unlock = function()
	{
		if myStates.Contains(myStatus)
		{
			myStates.Set(myStatus, false)
		}
	}

	/// @self StateMachine
	/// @return {String}
	/// @pure
	static GetStatus = function()
	{
		return myStatus
	}

	/// @self StateMachine
	/// @return {Bool}
	/// @pure
	static Get = function()
	{
		return GetOf(myStatus)
	}

	/// @self StateMachine
	/// @param {String} state
	/// @return {Bool}
	/// @pure
	static GetOf = function(state)
	{
		if myStates.Contains(state)
		{
			return myStates.Get(state)
		}
		else
		{
			return false
		}
	}
}

/// @param {String} name
function StateNode(name) constructor
{
	myName = name

	myPreceeds = {}
}
