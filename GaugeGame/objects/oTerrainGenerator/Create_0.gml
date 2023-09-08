/// @description Create Terrains
horzChunks = gameSetting.horzChunks
vertChunks = gameSetting.vertChunks
mySize = horzChunks * vertChunks

/// @self oTerrainGenerator
/// @param {Real} _
var creator = function(_) { return new Chunk(0, gameSetting.horzTiles, gameSetting.vertTiles) }
myData = array_create_ext(mySize, creator);

// stores indices of chunk
myPath = array_create(mySize, 0)
secondPath = array_create(mySize, 0)

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
