enum ChunkCategory
{
	Normal = 1, Open,
}

/// @param {Real} category
/// @param {Real} htiles
/// @param {Real} vtiles
function Chunk(category, htiles, vtiles) constructor
{
	myCategory = category
	horzTiles = htiles
	vertTiles = vtiles
	myData = array_create(htiles * vtiles, 0)

	/// @self Chunk
	/// @param {Real} x
	/// @param {Real} y
	/// @return {Real}
	/// @pure
	static At = function(x, y)
	{
		return myData[x + y * horzTiles]
	}
}

/// @param {Real} category
/// @param {Real} htiles
/// @param {Real} vtiles
/// @return {Struct.Chunk}
function MakeChunk(category, htiles, vtiles)
{
	return new Chunk(category, htiles, vtiles)
}
