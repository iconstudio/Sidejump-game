/// @description Create Terrains
horzChunks = gameUnit.horzChunks
vertChunks = gameUnit.vertChunks
mySize = horzChunks * vertChunks

mmapData = new Json("test/Everything.tsj")

/// @self oTerrainGenerator
/// @param {Real} _
var creator = function(_) { return new Chunk(0, gameUnit.horzTiles, gameUnit.vertTiles) }
myData = array_create_ext(mySize, creator);

// stores indices of chunk
correctPath = array_create(mySize, 0)
alterPath = array_create(mySize, 0)

beginIndex = irandom(horzChunks - 1)
endIndex = mySize - horzChunks + irandom_range(0, horzChunks - 1)
beginNode = myData[beginIndex]
endNode = myData[endIndex]

/// @self oTerrainGenerator
/// @param {Struct.Chunk} chunk
/// @param {Real} _
var initiator = function(chunk, _)
{

}

array_foreach(myData, initiator)

alarm[0] = 1
