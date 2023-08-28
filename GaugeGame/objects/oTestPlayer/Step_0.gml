var can_act = CanAction()
if can_act
{
	var keyc_lt = keyboard_check(vk_left)
	var keyc_rt = keyboard_check(vk_right)
	var keyp_lt = keyboard_check_pressed(vk_left)
	var keyp_rt = keyboard_check_pressed(vk_right)
	var keyr_lt = keyboard_check_released(vk_left)
	var keyr_rt = keyboard_check_released(vk_right)
	var keyc_rn = keyboard_check(vk_shift)

	if keyp_lt
	{
		moveDir = -1
	}
	else if keyr_lt
	{
		if keyc_rt
		{
			moveDir = 1
		}
		else 
		{
			moveDir = 0
		}
	}

	if keyp_rt
	{
		moveDir = 1
	}
	else if keyr_rt
	{
		if keyc_lt
		{
			moveDir = -1
		}
		else 
		{
			moveDir = 0
		}
	}

	if 0 != moveDir
	{
		SetState("Moving")

		if keyc_rn
		{
			myVelocity.SetHspeed(70 * moveDir)
		}
		else
		{
			myVelocity.SetHspeed(50 * moveDir)
		}
	}
	else
	{
		SetState("Idle")
	}
}

// move now
event_inherited()

var on_ground = IsOnGround()

if can_act
{
	if wasOnGround and not on_ground
	{
		if justCoyote
		{
			if 0 < coyoteTime
			{
				coyoteTime--
			}
			else
			{
				wasOnGround = false

				if not adjustingJump
				{
					myVelocity.useGravity = true
				}
			}
		}

		if not justCoyote
		{
			justCoyote = true
			coyoteTime = coyotePeriod
			myVelocity.useGravity = false
		}
	}

	if adjustingJump
	{
		//var jump_prog = 1 - jumpTime / jumpPeriod
		//var jump_value = jump_prog
		//animcurve_channel_evaluate(jumpCurveChannel, jump_prog)

		//myVelocity.AddSpeeds(0, jump_value * -jumpSpeed)
		//myVelocity.AddSpeeds(0, -jumpSpeed)

		if on_ground and not justAdjusting
		{
			EndAdjJump()
		}
		else if jumpTime-- <= 0
		{
			EndAdjJump()
		}
		else if not justAdjusting
		{
			if myVelocity.isCollidedTop
			{
				EndAdjJump()
			}
		}

		if not on_ground
		{
			justAdjusting = false
		}
	}
}
