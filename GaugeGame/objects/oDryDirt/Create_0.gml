event_inherited()

SetName("Dry Dirt")

/// @self oDryDirt
function GetAutotileTable()
{
	static table =
	[
		[0, 1, 2], // 0 
		[3, 4, 5],
		[24, 25, 26],
		[3, 4, 5],
		[6, 7, 8], // 4
		[12, 13, 14],
		[6, 7, 8],
		[12, 13, 14],
		[9, 10, 11],
		[15, 16, 17], // 9
		[9, 10, 11],
		[15, 16, 17],
		[20, 21, 22],
		[17, 18, 19],
		[20, 21, 22],
		[3, 4, 5], // 15
	]

	return table
}
