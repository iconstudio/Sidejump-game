event_inherited()

SetName("Temple Brick")

/// @self oDryDirt
/// @param {Real} index
/// @return {Real}
/// @pure
function GetAutotileTable(index)
{
	var ld = (0 != index & AutotileDisjunctions.Ld)
	var rd = (0 != index & AutotileDisjunctions.Rd)
	
	if ld
	{
		return index + 16
	}

	index &= ~AutotileDisjunctions.Lu
	index &= ~AutotileDisjunctions.Ru
	index &= ~AutotileDisjunctions.Ld
	index &= ~AutotileDisjunctions.Rd

	return index
}
