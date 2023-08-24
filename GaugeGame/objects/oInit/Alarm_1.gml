/// @description Goto the next room
if (audioLoaded)
{
	instance_create_layer(0, 0, "System", oGlobal)

	room_goto_next()
}
