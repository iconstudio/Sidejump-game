if adjustingJump
{
	//var jump_prog = 1 - jumpTime / jumpPeriod
	//var jump_value = jump_prog
	//animcurve_channel_evaluate(jumpCurveChannel, jump_prog)

	//myVelocity.AddSpeeds(0, jump_value * -jumpSpeed)
	//myVelocity.AddSpeeds(0, -jumpSpeed)

	if myVelocity.isCollidedTop
	{
		adjustingJump = false
	}

	if IsOnGround() and not wasOnGround
	{
		adjustingJump = false
	}

	if jumpTime-- <= 0
	{
		adjustingJump = false
	}

	if wasOnGround and not IsOnGround()
	{
		wasOnGround = false
	}
}

event_inherited()
