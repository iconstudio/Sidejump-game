/// @description menu_entry_execute(entry)
/// @function menu_entry_execute
/// @param entry { instance }
with argument0 {
	if script_exists(callback)
		script_execute(callback, id)
	event_user(2)
}
