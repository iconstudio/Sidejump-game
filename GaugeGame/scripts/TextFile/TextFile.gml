enum TextFileOpenTypes
{
	Read = 0, Write = 1, Append = 2,
	ReadOnly = 0,
	Overwrite = 1,
}

/// @param {String} filepath
/// @param {Real} [open_type]
function TextFile(filepath, open_type = TextFileOpenTypes.Read)
{
	if TextFileOpenTypes.Read == open_type
	{
		return new ReadOnlyTextFile(filepath)
	}
	else if TextFileOpenTypes.Write == open_type
	{
		return new WritableTextFile(filepath, true)
	}
	else if TextFileOpenTypes.Append == open_type
	{
		return new WritableTextFile(filepath)
	}
}

/// @param {String} filepath
function ReadOnlyTextFile(filepath) constructor
{
	myHandle = file_text_open_read(filepath)

	/// @self ReadOnlyTextFile
	/// @param {Bool} [nextline]
	/// @return {String}
	static Read = function(nextline = false)
	{
		if nextline
		{
			var result = file_text_read_string(myHandle)
			file_text_readln(myHandle)
			return result
		}
		else
		{
			return file_text_read_string(myHandle)
		}
	}

	/// @self ReadOnlyTextFile
	/// @return {String}
	static ReadLine = function()
	{
		return file_text_readln(myHandle)
	}

	/// @self ReadOnlyTextFile
	/// @return {Bool}
	static IsValid = function()
	{
		return -1 != myHandle
	}

	/// @self ReadOnlyTextFile
	/// @return {Bool}
	static IsEndOfLine = function()
	{
		return file_text_eoln(myHandle)
	}

	/// @self ReadOnlyTextFile
	/// @return {Bool}
	static IsEndOfFile = function()
	{
		return file_text_eof(myHandle)
	}

	/// @self ReadOnlyTextFile
	static Close = function()
	{
		file_text_close(myHandle)
		myHandle = -1
	}
}

/// @param {String} filepath
/// @param {Bool} [rewrite]
function WritableTextFile(filepath, rewrite = false) : ReadOnlyTextFile(filepath) constructor
{
	/// @self WritableTextFile
	/// @param {Any} value
	/// @param {Bool} [nextline]
	static Write = function(value, nextline = false)
	{
		if is_real(value)
		{
			file_text_write_real(myHandle, value)
		}
		else if is_string(value)
		{
			file_text_write_string(myHandle, value)
		}
		else
		{
			file_text_write_string(myHandle, string(value))
		}

		if nextline
		{
			file_text_writeln(myHandle)
		}
	}

	/// @self WritableTextFile
	/// @param {Any} value
	/// @param {Bool} [nextline]
	static WriteLine = function(value, nextline = false)
	{
		Write(value, true)
	}
}
