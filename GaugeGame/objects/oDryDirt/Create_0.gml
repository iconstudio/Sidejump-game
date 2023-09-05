event_inherited()

SetName("Dry Dirt")

/// @self oDryDirt
/// @pure
function GetAutotileTable()
{
	static table =
	[
		[00, 01, 02], // 0
		[03, 04, 05], // 1 (Up)
		[06, 07, 08], // 2 (Down)
		[09, 10, 11], // 3 (Uo Down)

		[12, 13, 14], // 4 (Left)
		[15, 16, 17], // 5 (Left Up)
		[18, 19, 20], // 6 (Left Down)
		[21, 22, 23], // 7 (Left Up Down)
		
		[24, 25, 26], // 8 (Right)
		[27, 28, 29], // 9 (Right Up)
		[30, 31, 32], // 10 (Right Down)
		[27, 28, 29], // 11 (Right Up Down)
		
		[33, 34, 35], // 12 (LR)
		[36, 37, 38], // 13 (LR Up)
		[39, 40, 41], // 14 (LR Down)
		[09, 10, 11], // 15 (LR Up Down, Single)
	]

	return table
}
