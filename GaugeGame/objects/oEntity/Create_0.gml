event_inherited()

myState = new StateMachine("Idle")
myState.Add("Moving")
myState.Add("Dead")

/// @self oEntity
/// @param {ID.oEntity} target
function EntityBottomCollider(target)
{
	//var state = GetState()

	if CanAction()
	{
		DefaultBottomCollider(target)
	}
	else
	{
		var yvel = myVelocity.GetYSpeed()

		if yvel < 30
		{
			myVelocity.SetVspeed(0)
		}
		else
		{
			myVelocity.SetVspeed(-yvel * 0.7)
		}
	}
}
myVelocity.colliderOnBottom = EntityBottomCollider

/// @self oEntity
/// @param {String} state
/// @return {Bool}
function SetState(state)
{
	return myState.Set(state)
}

/// @self oEntity
/// @return {String}
/// @pure
function GetState()
{
	return myState.GetStatus()
}

/// @self oEntity
/// @return {Bool}
/// @pure
function CanAction()
{
	return myState.GetStatus() != "Dead"
}
