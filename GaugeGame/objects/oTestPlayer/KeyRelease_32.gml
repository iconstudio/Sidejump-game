/// @description End Jump
if isJumping
{
	var yvel = myVelocity.GetVspeed()
	myVelocity.SetVspeed(yvel * 0.8)

	coyoteTime = 0
	EndAdjJump()
}
