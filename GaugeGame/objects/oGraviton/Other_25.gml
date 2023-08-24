/// @description Move with physics
var hspd = myVelocity.GetXSpeed()
var vspd = myVelocity.GetYSpeed()

if 0 != hspd
{
	var tspd = gameSetting.CalcVelocity(hspd)

	if hspd < 0
	{
		MoveContactX(tspd, myVelocity.collisionGrpLt, myVelocity.colliderOnSide)
	}
	else
	{
		MoveContactX(tspd, myVelocity.collisionGrpRt, myVelocity.colliderOnSide)
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

if not myVelocity.isCollidedBottom
{
	myVelocity.AddSpeed(0, gameSetting.worldGravity)
}

if 0 <= vspd
{
	MoveContactY(gameSetting.CalcVelocity(vspd), myVelocity.collisionGrpBt, myVelocity.colliderOnBottom)
}
else
{
	MoveContactY(gameSetting.CalcVelocity(vspd), myVelocity.collisionGrpTp, myVelocity.colliderOnTop)
}
