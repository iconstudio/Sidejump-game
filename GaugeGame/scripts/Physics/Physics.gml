function Physics()
{
	myVelocity.isCollidedTop = true
	myVelocity.isCollidedBottom = true
	myVelocity.isCollidedSide = true

	myVelocity.collisionGrpLt = [oSolid]
	myVelocity.collisionGrpRt = [oSolid]
	myVelocity.collisionGrpTp = [oSolid] // top
	myVelocity.collisionGrpBt = [oSolid, oPlatform] // bottom

	myVelocity.colliderOnTop = DefaultTopCollider
	myVelocity.colliderOnBottom = DefaultBottomCollider
	myVelocity.colliderOnSide = DefaultSideCollider

	myVelocity.useGravity = true

	myVelocity.useFriction = true
	myVelocity.frictionHrzFunctor = DefaultHrzFriction
	myVelocity.frictionVrtFunctor = DefaultVrtFriction

	myVelocity.useLimit = true
	myVelocity.limitHrzunctor = DefaultHrzFriction
	myVelocity.limitVrtFunctor = DefaultVrtFriction
}

/// @self oGameObject
/// @param {Real} dist
/// @param {Array<Asset.GMObject>} collisions
/// @param {Function} [collider]
/// @return {Bool}
function MoveContactX(dist, collisions, collider = DefaultSideCollider)
{
	var checkx1 = 0, checkx2 = 0

	if dist <= 0
	{
		var adist = abs(dist)
		var rdist = round(adist)

		checkx1 = bbox_left + 1
		checkx2 = bbox_left - max(rdist, 1)

		var ltcollide = collision_rectangle(checkx2, bbox_top, checkx1, bbox_bottom, collisions, false, true)
		if noone == ltcollide
		{
			x += dist
		}
		else
		{
			for (var i = 0; i < rdist; i++)
			{
				if place_meeting(x - 1, y, collisions)
				{
					x = ceil(x)
					collider(id)
					return true
				}

				x--
			}
		}
	}
	else
	{
		var rdist = round(dist)

		checkx1 = bbox_right - 1
		checkx2 = bbox_right + max(rdist, 1)

		var rtcollide = collision_rectangle(checkx1, bbox_top, checkx2, bbox_bottom, collisions, false, true)
		if noone == rtcollide
		{
			x += dist
		}
		else
		{
			for (var i = 0; i < rdist; i++)
			{
				if place_meeting(x + 1, y, collisions)
				{
					x = floor(x)
					collider(id)
					return true
				}

				x++
			}
		}
	}

	return false
}

/// @self oGameObject
/// @param {Real} dist
/// @param {Array<Asset.GMObject>} collisions
/// @param {Function} collider
/// @return {Bool}
function MoveContactY(dist, collisions, collider)
{
	if 0 <= dist
	{
		var rdist = round(dist)
		
		for (var i = 0; i < rdist; i++)
		{
			if place_meeting(x, y + 1, collisions)
			{
				collider(id)
				y = round(y)

				return true
			}

			y++
		}
	}
	else
	{
		var adist = abs(dist)
		var rdist = round(adist)

		for (var i = 0; i < rdist; i++)
		{
			if place_meeting(x, y - 1, collisions)
			{
				collider(id)
				y = floor(y)

				return true
			}

			y--
		}
	}

	return false
}

/// @self oGraviton
/// @param {ID.oGraviton, ID.oEntity} target
function DefaultTopCollider(target)
{
	with target
	{
		myVelocity.SetVspeed(0)
	}
}

/// @self oGraviton
/// @param {ID.oGraviton, ID.oEntity} target
function DefaultBottomCollider(target)
{
	with target
	{
		myVelocity.SetVspeed(0)
	}
}

/// @self oGraviton
/// @param {ID.oGraviton, ID.oEntity} target
function DefaultSideCollider(target)
{
	with target
	{
		myVelocity.SetHspeed(0)
	}
}

/// @param {ID.Instance, ID.oGraviton, ID.oEntity} target
/// @param {Real} xspeed
/// @return {Real}
/// @pure
function DefaultHrzFriction(target, xspeed)
{
	return xspeed * 0.9
}

/// @param {ID.Instance, ID.oGraviton, ID.oEntity} target
/// @param {Real} yspeed
/// @return {Real}
/// @pure
function DefaultVrtFriction(target, yspeed)
{
	return yspeed
}

/// @self oGraviton
/// @return {Bool}
/// @pure
function IsOnGround()
{
	return myVelocity.isCollidedBottom
}

/// @self oGraviton
/// @return {Bool}
/// @pure
function IsUsingLimit()
{
	return myVelocity.useLimit
}

/// @self oGraviton
/// @return {Bool}
/// @pure
function IsUsingFriction()
{
	return myVelocity.useFriction
}