/// @description Move with physics
var use_slope = myVelocity.useSlope
var hspd = myVelocity.GetXSpeed()
var vspd = myVelocity.GetYSpeed()

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

			var mv_ub = new Vector2(mdist, sdist_ub)
			var uv_ub = mv_ub.GetUnit()
			var ux_ub = max(1, uv_ub.x) * mdir;
			var uy_ub = max(1, uv_ub.y)

			if 0 < vspd
			{
				slope_ub *= 0.5
			}

			// seek best position
			for (var i = 0; i < mdist; ++i)
			{
				MoveContactY(-uy_ub, myVelocity.collisionGrpTp, true, undefined)
				MoveContactX(mdir, tgrp, true, undefined)
				MoveContactY(uy_ub, myVelocity.collisionGrpBt, true, undefined)
				MoveContactX(-mdir, tgrp, true, undefined)
			}

			var side_collision = noone
			if 0 < mdir
			{
				side_collision = CollisionRight(rdist, tgrp, true)
			}
			else
			{
				side_collision = CollisionLeft(rdist, tgrp, true)
			}

			if noone != side_collision
			{
				if 0 < mdir
					x = floor(x)
				else
					x = ceil(x)

				// it collided at last
				myVelocity.colliderOnSide(id)
			}
		}
		else
		{
			// trying to move to the lower slope
			var slope_lb = tan(degtorad(myVelocity.slopeLower))
			var sdist_lb = max(1, mdist * slope_lb)

			if vspd <= 0
			{
				slope_lb *= 0.5
			}

			var cy = y
			MoveContactY(sdist_lb, myVelocity.collisionGrpBt, true, undefined)

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
	var btcollide = collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 1, myVelocity.collisionGrpBt, use_slope, true)
	if noone == btcollide
	{
		myVelocity.isCollidedBottom = false
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

	myVelocity.isCollidedBottom = false
}

if 0 <= vspd
{
	if MoveContactY(gameSetting.CalcVelocity(vspd), myVelocity.collisionGrpBt, use_slope, myVelocity.colliderOnBottom)
	{
		myVelocity.isCollidedBottom = true
	}
}
else
{
	if MoveContactY(gameSetting.CalcVelocity(vspd), myVelocity.collisionGrpTp, use_slope, myVelocity.colliderOnTop)
	{
		myVelocity.isCollidedTop = true
	}
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
