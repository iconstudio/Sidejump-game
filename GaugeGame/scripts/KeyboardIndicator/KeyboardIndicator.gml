/// @param {Constant.VirtualKey or Real} key
/// @desc Creates a keyboard key indicator
function KeyboardIndicator(key) : InputIndicator() constructor
{
	myKeycode = key

	/// @self KeyboardIndicator
	/// @func Update
	/// @return {Undefined}
	static Update = function()
	{
		isPressing = keyboard_check(myKeycode)
		isPressed = keyboard_check_pressed(myKeycode)
		isReleased = keyboard_check_released(myKeycode)
	}

	/// @self KeyboardIndicator
	/// @func SetKeycode
	/// @param {Constant.VirtualKey or Real} keycode 
	/// @return {Undefined}
	static SetKeycode = function(keycode)
	{
		myKeycode = keycode
	}
}
