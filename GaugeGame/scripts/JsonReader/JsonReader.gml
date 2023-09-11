/// @param {String} filepath
function JsonReader(filepath) constructor
{
	rawData = ""

	var txt = new ReadOnlyTextFile(filepath)
	if not txt.IsValid()
	{
		throw "No Json file found"
	}

	while not txt.IsEndOfFile()
	{
		rawData += txt.ReadLine()
	}
	txt.Close()

	if 0 == string_length(rawData)
	{
		throw "Cannot read the data file"
	}

	show_debug_message("Read Json Contents: \n" +  rawData)
	myData = json_parse(rawData)
}
