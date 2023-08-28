/// @description End Jump
if isJumping and not wasOnGround
{
	var yvel = myVelocity.GetVspeed()
	myVelocity.SetVspeed(yvel * 0.6)

	coyoteTime = 0
	EndAdjJump()
}
