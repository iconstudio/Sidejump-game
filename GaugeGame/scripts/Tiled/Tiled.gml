/// @param {String} filepath
function Tiled(filepath) constructor
{
	
}

/// @param {String} filepath
function LoadTiled(filepath)
{
	var buf = buffer_create(32, buffer_grow, buffer_u8)

	//file_
	buffer_load_async(buf, filepath, 0, )

	return buf
}
