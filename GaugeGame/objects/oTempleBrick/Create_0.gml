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
	var lu = (0 != index & AutotileDisjunctions.Lu)
	var ru = (0 != index & AutotileDisjunctions.Ru)

	index &= ~AutotileDisjunctions.Lu
	index &= ~AutotileDisjunctions.Ru
	index &= ~AutotileDisjunctions.Ld
	index &= ~AutotileDisjunctions.Rd

	if ld and rd
	{
		if lu and ru
		{
			return index
		}
		else if not lu and ru
		{
			return index + 16
		}
		else if lu and not ru
		{
			return index + 32
		}
		else
		{
			return index + 48
		}
	}
	else if not ld and rd
	{
		if ru
		{
			return index
		}
		else
		{
			return index + 32
		}
	}
	else if ld and not rd
	{
		if lu
		{
			return index
		}
		else
		{
			return index + 16
		}
	}

	return index
}
