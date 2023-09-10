/// @param {Real} category
/// @param {ID.oGameObject} target
/// @param {Asset.GMObject or Array<Asset.GMObject> or Array} checks
/// @param {Array<Asset.GMSprite> or Array<Array<Asset.GMSprite>> or Array<Real> or Array<Array<Real>> or Function} grps
/// @return {Real, Asset.GMSprite, Undefined}
/// @pure
function AutotileCreate(category, target, checks, grps)
{
	var dir = AutoTileCollision(category, target, checks)

	if is_callable(grps)
	{
		return grps(dir)
	}
	else if is_array(grps)
	{
		if 0 == array_length(grps)
		{
			throw "Invalid sprite group argument"
		}

		var item = grps[dir]
		if is_array(item)
		// ※ Variants
		{
			var slen = array_length(item)
			if 0 == slen
			{
				throw "Invalid tile variant group"
			}

			return item[irandom(slen - 1)]
		}
		else if not is_undefined(item)
		// ※ Single tile
		{
			return item
		}
		else
		{
			throw $"Invalid sprites argument on { dir }"
		}
	}
	else
	{
		throw "Invalid argument 'grps'"
	}
}
