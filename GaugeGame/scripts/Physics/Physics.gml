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

	myVelocity.useXFriction = true
	myVelocity.useYFriction = true
}

/// @param {Real} dist
/// @param {Array} collisions
/// @param {Function} [collider]
function MoveContactX(dist, collisions, collider = DefaultSideCollider)
{
	var checkx1 = 0, checkx2 = 0

	if dist <= 0
	{
		var adist = abs(dist)
		var rdist = round(adist)

		checkx1 = bbox_left
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
					break
				}

				x--
			}

			x = round(x)
			collider(id)
		}
	}
	else
	{
		var rdist = round(dist)

		checkx1 = bbox_right
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
					break
				}

				x++
			}

			x = floor(x)
			collider(id)
		}
	}
}

/// @param {Real} dist
/// @param {Array} collisions
/// @param {Function} collider
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

				myVelocity.isCollidedBottom = true
				break
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

				myVelocity.isCollidedTop = true
				break
			}

			y--
		}
	}
}

/// @param {Asset.GMObject or Id.Instance} target
function DefaultTopCollider(target)
{
	with target
	{
		myVelocity.SetVspeed(0)
	}
}

/// @param {Asset.GMObject or Id.Instance} target
function DefaultBottomCollider(target)
{
	with target
	{
		myVelocity.SetVspeed(0)
	}
}

/// @param {Asset.GMObject or Id.Instance} target
function DefaultSideCollider(target)
{
	with target
	{
		myVelocity.SetHspeed(0)
	}
}
