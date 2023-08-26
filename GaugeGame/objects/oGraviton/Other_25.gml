/// @description Move with physics
var hspd = myVelocity.GetXSpeed()
var vspd = myVelocity.GetYSpeed()

if 0 != hspd
{
	var tspd = gameSetting.CalcVelocity(hspd)
	var tgrp;

	if hspd < 0
	{
		tgrp = myVelocity.collisionGrpLt
	}
	else
	{
		tgrp = myVelocity.collisionGrpRt
	}

	if MoveContactX(tspd, tgrp, myVelocity.colliderOnSide)
	{
		
	}
}

if 0 <= vspd
{
	var btcollide = collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 1, myVelocity.collisionGrpBt, false, true)
	if noone == btcollide
	{
		myVelocity.isCollidedBottom = false
	}

	myVelocity.isCollidedTop = false
}
else
{
	var tpcollide = collision_rectangle(bbox_left, bbox_top - 1, bbox_right, bbox_top, myVelocity.collisionGrpBt, false, true)
	if noone == tpcollide
	{
		myVelocity.isCollidedTop = false
	}

	myVelocity.isCollidedBottom = false
}

if 0 <= vspd
{
	if MoveContactY(gameSetting.CalcVelocity(vspd), myVelocity.collisionGrpBt, myVelocity.colliderOnBottom)
	{
		myVelocity.isCollidedBottom = true
	}
}
else
{
	if MoveContactY(gameSetting.CalcVelocity(vspd), myVelocity.collisionGrpTp, myVelocity.colliderOnTop)
	{
		myVelocity.isCollidedTop = true
	}
}

if not IsOnGround()
{
	myVelocity.AddSpeed(0, gameSetting.worldGravity)
}

if myVelocity.useLimit
{
	with myVelocity
	{
		SetHspeed(frictionHrzFunctor(GetXSpeed()))
		SetVspeed(frictionVrtFunctor(GetYSpeed()))
	}
}
