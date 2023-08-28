function Velocity() constructor
{
	mySpeed = new Vector2()
	myPredicate = DefaultVelocityFn

	isAbsCached = false
	cachedAbs = 0
	isAngleCached = true
	cachedAngle = new Vector2()
	
	/// @self Velocity
	/// @param {Struct.Velocity} velocity
	static Set = function(velocity)
	{
		mySpeed.mySpeed = velocity.mySpeed

		isAbsCached = false
		isAngleCached = false
	}

	/// @self Velocity
	/// @param {Struct.Vector2} vector
	static SetVelocity = function(vector)
	{
		mySpeed = vector

		isAbsCached = false
		isAngleCached = false
	}

	/// @self Velocity
	/// @param {Real} spd
	static SetSpeed = function(spd)
	{
		var dir = GetDirection()
		mySpeed.x = dir.x * spd
		mySpeed.y = dir.y * spd

		isAbsCached = false
	}

	/// @self Velocity
	/// @param {Real} xspd horizontol speed
	static SetHspeed = function(xspd)
	{
		mySpeed.x = xspd

		isAbsCached = false
		isAngleCached = false
	}

	/// @self Velocity
	/// @param {Real} yspd vertical speed
	static SetVspeed = function(yspd)
	{
		mySpeed.y = yspd

		isAbsCached = false
		isAngleCached = false
	}

	/// @self Velocity
	/// @param {Struct.Vector2} vector
	static SetDirection = function(vector)
	{
		var spd = GetSpeed()
		var dir = vector.GetDirection()

		mySpeed = dir
		mySpeed.x = dir.x * spd
		mySpeed.y = dir.y * spd

		isAbsCached = false
		if not isAngleCached
		{
			isAngleCached = true
			cachedAngle = dir
		}
	}

	/// @self Velocity
	/// @param {Real} dir
	static SetAngle = function(dir)
	{
		var spd = GetSpeed()
		mySpeed.x = lengthdir_x(spd, dir)
		mySpeed.y = lengthdir_y(spd, dir)

		isAbsCached = false
		if not isAngleCached
		{
			isAngleCached = true
			cachedAngle.x = lengthdir_x(1, dir)
			cachedAngle.y = lengthdir_x(1, dir)
		}
	}

	/// @self Velocity
	/// @param {Struct.Velocity} velocity
	static Add = function(velocity)
	{
		mySpeed.x += velocity.mySpeed.x
		mySpeed.y += velocity.mySpeed.y

		isAbsCached = false
		isAngleCached = false
	}

	/// @self Velocity
	/// @param {Struct.Vector2} vector
	static AddVelocity = function(vector)
	{
		mySpeed.x += vector.x
		mySpeed.y += vector.y

		isAbsCached = false
		isAngleCached = false
	}

	/// @self Velocity
	/// @param {Real} hsp
	static AddSpeed = function(hspd, vspd)
	{
		mySpeed.x += hspd
		mySpeed.y += vspd

		isAbsCached = false
		isAngleCached = false
	}

	/// @self Velocity
	/// @param {Real} hspd
	/// @param {Real} vspd
	static AddSpeeds = function(hspd, vspd)
	{
		mySpeed.x += hspd
		mySpeed.y += vspd

		isAbsCached = false
		isAngleCached = false
	}

	/// @self Velocity
	/// @return {Real}
	static GetSpeed = function()
	{
		if not isAbsCached
		{
			cachedAbs = mySpeed.GetAbsolute()
			isAbsCached = true
		}

		return cachedAbs
	}

	/// @self Velocity
	/// @return {Real}
	/// @pure
	static GetHspeed = function()
	{
		return mySpeed.x
	}

	/// @self Velocity
	/// @return {Real}
	/// @pure
	static GetVspeed = function()
	{
		return mySpeed.y
	}

	/// @self Velocity
	/// @return {Real}
	/// @pure
	static GetXSpeed = function()
	{
		return mySpeed.x
	}

	/// @self Velocity
	/// @return {Real}
	/// @pure
	static GetYSpeed = function()
	{
		return mySpeed.y
	}

	/// @self Velocity
	/// @return {Struct.Vector2}
	static GetDirection = function()
	{
		if not isAngleCached
		{
			cachedAngle = mySpeed.GetUnit()
			isAngleCached = true
		}

		return cachedAngle
	}

	/// @self Velocity
	/// @param {Function} fn
	static SetUpdater = function(fn)
	{
		myPredicate = fn
	}
	
	/// @self Velocity
	/// @param {ID.Instance} target
	static MoveWith = function(target)
	{
		if is_callable(myPredicate)
		{
			myPredicate(target, mySpeed.x, mySpeed.y)
		}
	}
}

/// @param {ID.Instance} target
/// @param {Real} vx
/// @param {Real} vy
function DefaultVelocityFn(target, vx, vy)
{
	var delta_steps = gameSetting.pixelPerStep

	target.x += vx * delta_steps
	target.y += vy * delta_steps
}
