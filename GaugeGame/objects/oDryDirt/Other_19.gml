sprite_index = choose(sDryDirt1, sDryDirt2, sDryDirt3)

var index = AutotileCreate(AutotileCategory.Simple, id, oDryDirt, GetAutotileTable())
if not is_undefined(index)
{
	image_index = index
}
