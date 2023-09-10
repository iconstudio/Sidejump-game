/// @param {Real} category
/// @param {ID.Instance, ID.oGameObject} target
/// @param {Asset.GMObject, Array<Asset.GMObject>, Array} checks
/// @return {Real}
/// @pure
function AutoTileCollision(category, target, checks)
{
	var dir = AutotileDisjunctions.None
	with target
	{
		var border = 8
		var cy1 = bbox_top - border
		var cy2 = bbox_bottom + border
		var cx1 = bbox_left - border
		var cx2 = bbox_right + border
		
		var up = collision_point(x, cy1, checks, false, true)
		var dw = collision_point(x, cy2, checks, false, true)
		var lt = collision_point(cx1, y, checks, false, true)
		var rt = collision_point(cx2, y, checks, false, true)

		if noone == up
		{
			dir |= AutotileDisjunctions.Up
		}
		if noone == dw
		{
			dir |= AutotileDisjunctions.Dw
		}
		if noone == lt
		{
			dir |= AutotileDisjunctions.Lt
		}
		if noone == rt
		{
			dir |= AutotileDisjunctions.Rt
		}

		if AutotileCategory.Simple != category
		{
			var lu = collision_point(cx1, cy1, checks, false, true)
			var ru = collision_point(cx2, cy1, checks, false, true)
			var ld = collision_point(cx1, cy2, checks, false, true)
			var rd = collision_point(cx2, cy2, checks, false, true)

			if noone == lu
			{
				dir |= AutotileDisjunctions.Lu
			}
			if noone == ru
			{
				dir |= AutotileDisjunctions.Ru
			}
			if noone == ld
			{
				dir |= AutotileDisjunctions.Ld
			}
			if noone == rd
			{
				dir |= AutotileDisjunctions.Rd
			}
		}
	}

	return dir
}
