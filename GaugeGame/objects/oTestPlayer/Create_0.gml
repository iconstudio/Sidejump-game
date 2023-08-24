event_inherited()

isJumping = false
adjustingJump = false
wasOnGround = true

jumpMeters = 3.6
jumpDuration = 0.6 // seconds

jumpHeight = gameSetting.Meters(jumpMeters)
jumpPeriod = gameSetting.Seconds(jumpDuration)
jumpTime = jumpPeriod
//jumpSpeed = jumpHeight * gameSetting.worldGravity / sqr((1 / jumpDuration) * 2)
jumpSpeed = jumpHeight / jumpDuration - 0.5 * gameSetting.rawGravity * jumpDuration

jumpCurve = animcurve_get(curvePlayerJumpUpSpeed)
jumpCurveChannel = animcurve_get_channel(jumpCurve, 0)

/// @self oTestPlayer
/// @param {Asset.GMObject or Id.Instance} target
function TestPlayerBottomCollider(target)
{
	DefaultBottomCollider(target)
	target.isJumping = false
	target.adjustingJump = false
}

myVelocity.colliderOnBottom = TestPlayerBottomCollider

/// @self oTestPlayer
function DoJump()
{
	if not isJumping
	{
		myVelocity.AddSpeeds(0, -jumpSpeed)

		isJumping = true
		adjustingJump = true
		wasOnGround = true
		jumpTime = jumpPeriod
	}
}
