/// @param {Real} category
/// @param {ID.oGameObject} target
/// @param {Asset.GMObject or Array<Asset.GMObject> or Array} checks
/// @param {Array<Asset.GMSprite> or Array<Array<Asset.GMSprite>> or Array<Real> or Array<Array<Real>>} grps
/// @return {Real, Asset.GMSprite, Undefined}
/// @pure
function AutotileCreate(category, target, checks, grps)
{
	var result = undefined

	var groups_count = array_length(grps)
	if 0 == groups_count
	{
		throw "Invalid sprite group argument"
	}

	var dir = AutoTileCollision(category, target, checks)

	/*
	switch category
	{
		case AutotileCategory.Simple:
		{
		}
		break;

		case AutotileCategory.SimpleDiag:
		{
		}
		break;

		case AutotileCategory.Complex:
		{
		}
		break;

		default:
		{
			throw "Invalid tile category"
		}
	}
	*/

	var item = grps[dir]
	if is_array(item)
	// ※ Variants
	{
		var slen = array_length(item)
		if 0 == slen
		{
			throw "Invalid tile variant group"
		}

		result = item[irandom(slen - 1)]
	}
	else if not is_undefined(item)
	// ※ Single tile
	{
		result = item
	}
	else
	{
		throw $"Invalid sprites argument on { target.id }"
	}

	return result
}
