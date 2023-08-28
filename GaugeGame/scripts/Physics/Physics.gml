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
	myVelocity.limitHrzFunctor = DefaultHrzFriction
	myVelocity.limitVrtFunctor = DefaultVrtFriction

	myVelocity.useSlope = false
	myVelocity.slopeUpper = 50
	myVelocity.slopeUpperDist = gameSetting.meterToPixel * 0.2
	myVelocity.slopeLower = 30
	myVelocity.slopeLowerDist = gameSetting.meterToPixel * 0.2
}

/// @self oGameObject
/// @param {Real} dist
/// @param {Array<Asset.GMObject>} collisions
/// @param {Bool} precise
/// @return {ID.Instance}
function CollisionLeft(dist, collisions, precise)
{
	return collision_rectangle(bbox_left - max(1, dist), bbox_top, bbox_left + 1, bbox_bottom, collisions, precise, true)
}

/// @self oGameObject
/// @param {Real} dist
/// @param {Array<Asset.GMObject>} collisions
/// @param {Bool} precise
/// @return {ID.Instance}
function CollisionRight(dist, collisions, precise)
{
	return collision_rectangle(bbox_right - 1, bbox_top, bbox_left + max(1, dist), bbox_bottom, collisions, precise, true)
}

/// @self oGameObject
/// @param {Real} dist
/// @param {Array<Asset.GMObject>} collisions
/// @param {Bool} [precise]
/// @param {Function, undefined}[collider]
/// @return {Real}
function MoveContactX(dist, collisions, precise = false, collider = DefaultSideCollider)
{
	var mdir = sign(dist)
	var adist = abs(dist)
	var rdist = ceil(adist)

	var collision = noone
	if dist < 0
	{
		collision = CollisionLeft(rdist, collisions, precise)
	}
	else if 0 < dist
	{
		collision = CollisionRight(rdist, collisions, precise)
	}

	if noone == collision
	{
		x += dist

		return 0
	}
	else if 0 != dist
	{
		var i
		for (i = 0; i < rdist; i++)
		{
			if place_meeting(x + mdir, y, collisions)
			{
				if is_callable(collider) collider(id)

				break
			}

			x += mdir
		}

		return rdist - i
	}

	return adist
}

/// @self oGameObject
/// @param {Real} dist
/// @param {Array<Asset.GMObject>} collisions
/// @param {Bool} [precise]
/// @param {Function, undefined} collider
/// @return {Bool}
function MoveContactY(dist, collisions, precise = false, collider)
{
	if 0 <= dist
	{
		var rdist = round(dist)
		
		for (var i = 0; i < rdist; i++)
		{
			if place_meeting(x, y + 1, collisions)
			{
				if is_callable(collider) collider(id)
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
				if is_callable(collider) collider(id)
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
