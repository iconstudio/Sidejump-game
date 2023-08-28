event_inherited()

isRunning = false
isJumping = false

moveDir = 0
myVelocity.useSlope = true

coyoteDuration = 0.08 // seconds
coyotePeriod = gameSetting.Seconds(coyoteDuration)
coyoteTime = 0
justCoyote = false
wasOnGround = true

adjustingJump = false
justAdjusting = false
jumpSpeed = 90

jumpMeters = 3.6
jumpDuration = 0.2 // seconds
jumpCurve = animcurve_get(curvePlayerJumpUpSpeed)
jumpCurveChannel = animcurve_get_channel(jumpCurve, 0)
jumpHeight = gameSetting.Meters(jumpMeters)
jumpPeriod = gameSetting.Seconds(jumpDuration)
jumpTime = 0
//jumpSpeed = jumpHeight * gameSetting.worldGravity / sqr((1 / jumpDuration) * 2)
//jumpSpeed = jumpHeight / jumpDuration - 0.25 * gameSetting.Meters(gameSetting.rawGravity) * jumpDuration
//jumpSpeed = 180

/// @self oTestPlayer
/// @param {ID.oTestPlayer} target
function TestPlayerBottomCollider(target)
{
	EntityBottomCollider(target)

	target.wasOnGround = true
	target.EndJump()
}

/// @self oTestPlayer
/// @param {ID.oTestPlayer} target
/// @param {Real} xspeed
/// @pure
function TestPlayerXfriction(target, xspeed)
{
	with target
	{
		var state = GetState()

		if state == "Moving"
		{
			return xspeed
		}
		else
		{
			if IsOnGround()
			{
				return xspeed * 0.5
			}
			else
			{
				return xspeed * 0.99
			}
		}
	}
}

myVelocity.colliderOnBottom = TestPlayerBottomCollider
myVelocity.frictionHrzFunctor = TestPlayerXfriction

/// @self oTestPlayer
function DoJump()
{
	if not isJumping
	{
		myVelocity.AddSpeeds(0, -jumpSpeed)

		isJumping = true
		audio_play_sound(sndPlayerJump, 0, false)

		BeginAdjJump()
	}
}

/// @self oTestPlayer
function BeginAdjJump()
{
	adjustingJump = true
	justAdjusting = true

	jumpTime = jumpPeriod
	myVelocity.useGravity = false
}

/// @self oTestPlayer
function EndAdjJump()
{
	adjustingJump = false
	justAdjusting = false
	jumpTime = 0

	myVelocity.useGravity = true
}

/// @self oTestPlayer
function EndJump()
{
	justCoyote = false
	coyoteTime = 0

	isJumping = false

	EndAdjJump()
}
