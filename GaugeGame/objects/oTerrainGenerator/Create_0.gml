/// @description Create Terrains
horzChunks = gameUnit.horzChunks
vertChunks = gameUnit.vertChunks
mySize = horzChunks * vertChunks

tileData = new JsonReader("test/Everything.tsj")

var tiledata = tileData.myData
var tilemap = tiledata[$ "tiles"]
if is_undefined(tilemap)
{
	throw "No tiles in the tilemap"
}

if not is_array(tilemap)
{
	throw "Invalid tilemap"
}

var tmap_len = array_length(tilemap)
if 0 == tmap_len
{
	throw "Empty tilemap"
}

tileMap = {}
for (var i = 0; i < tmap_len; ++i)
{
	var mapped_tile = tilemap[i]

	var tobj = mapped_tile[$ "type"]
	if is_undefined(tobj)
	{
		throw $"Found a invalid tile class at { i } in the tilemap { tilemap }"
	}

	var aind = asset_get_index(tobj)
	if -1 == aind
	{
		throw $"Cannot find asset at tile { i } in the tilemap { tilemap }"
	}

	var asty = asset_get_type(tobj)
	if asset_object != asty
	{
		throw $"Tile at { i } in the tilemap { tilemap } is not an object, but { asty }"
	}

	var tind = mapped_tile[$ "id"]
	if is_undefined(tobj)
	{
		throw $"Found a invalid tile id at { i } in the tilemap { tilemap }"
	}

	tileMap[$ string(tind)] = aind
}

mmapData = new JsonReader("test/testmap.json")

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
