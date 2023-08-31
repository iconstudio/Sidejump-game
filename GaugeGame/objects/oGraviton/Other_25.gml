/// @description Move with physics
var use_slope = myVelocity.useSlope
var hspd = myVelocity.GetXSpeed()
var vspd = myVelocity.GetYSpeed()

if 0 <= vspd
{
	var btcollide = collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 1, myVelocity.collisionGrpBt, use_slope, true)
	if noone == btcollide
	{
		myVelocity.isCollidedBottom = false
	}
	else
	{
		myVelocity.isCollidedBottom = true
	}

	myVelocity.isCollidedTop = false
}
else
{
	var tpcollide = collision_rectangle(bbox_left, bbox_top - 1, bbox_right, bbox_top, myVelocity.collisionGrpBt, use_slope, true)
	if noone == tpcollide
	{
		myVelocity.isCollidedTop = false
	}
	else
	{
		myVelocity.isCollidedTop = true
	}

	myVelocity.isCollidedBottom = false
}

if 0 != hspd
{
	var tgrp;
	if hspd < 0
	{
		tgrp = myVelocity.collisionGrpLt
	}
	else
	{
		tgrp = myVelocity.collisionGrpRt
	}

	var tspd = gameSetting.CalcVelocity(hspd)

	if use_slope
	{
		var adist = abs(tspd)
		var rdist = ceil(adist)
		var mdir = sign(tspd)

		// try move horizontal once
		var mdist = MoveContactX(rdist * mdir, tgrp, true, undefined)

		if 0 < mdist
		{
			// there be remaining distances
			// trying to move to the upper slope
			var slope_ub = tan(degtorad(myVelocity.slopeUpper)) * 2
			var sdist_ub = min(max(1, mdist * slope_ub), myVelocity.slopeUpperDist)

			if 0 < vspd
			{
				slope_ub *= 0.5
			}

			// seek best position
			repeat mdist
			{
				MoveContactY(-sdist_ub, myVelocity.collisionGrpTp, true, undefined)
				MoveContactX(mdir, tgrp, true, undefined)
				myVelocity.isCollidedBottom = MoveContactY(sdist_ub, myVelocity.collisionGrpBt, true, undefined) or myVelocity.isCollidedBottom

				if IsUsingFriction()
				{
					myVelocity.SetHspeed(myVelocity.frictionHrzFunctor(id, hspd))
				}
			}

			var side_collision = noone
			if 0 < mdir
			{
				side_collision = CollisionRight(1, tgrp, true)
			}
			else
			{
				side_collision = CollisionLeft(1, tgrp, true)
			}

			if noone != side_collision
			{
				// it collided at last
				myVelocity.colliderOnSide(id)
			}
		}
		else
		{
			// trying to move to the lower slope
			var slope_lb = tan(degtorad(myVelocity.slopeLower))
			var sdist_lb = max(1, mdist * slope_lb)

<<<<<<< HEAD
=======
			if vspd < 0
			{
				slope_lb *= 0.5
			}

>>>>>>> efd19a8 (dirt tiles)
			var cy = y
			myVelocity.isCollidedBottom = MoveContactY(sdist_lb, myVelocity.collisionGrpBt, true, undefined) or myVelocity.isCollidedBottom

			if IsUsingFriction()
			{
				myVelocity.SetHspeed(myVelocity.frictionHrzFunctor(id, hspd) * 0.667)
			}

			if myVelocity.slopeLowerDist < y - cy
			{
				y = cy + myVelocity.slopeLowerDist
			}
		}
	}
	else
	{
		MoveContactX(tspd, tgrp, false, myVelocity.colliderOnSide)
	}
}

if 0 <= vspd
{
	MoveContactY(gameSetting.CalcVelocity(vspd), myVelocity.collisionGrpBt, use_slope, myVelocity.colliderOnBottom)
}
else
{
	MoveContactY(gameSetting.CalcVelocity(vspd), myVelocity.collisionGrpTp, use_slope, myVelocity.colliderOnTop)
}

if not IsOnGround()
{
	if myVelocity.useGravity
	{
		myVelocity.AddSpeed(0, gameSetting.worldGravity)
	}
}

if IsUsingFriction()
{
	var target = id
	with myVelocity
	{
		SetHspeed(frictionHrzFunctor(target, GetHspeed()))
		SetVspeed(frictionVrtFunctor(target, GetVspeed()))
	}
}
