using System.Collections.Immutable;
using System.Diagnostics;
using System.Diagnostics.Contracts;
using System.Text.Json.Serialization;

namespace TestEditor.Contents
{
	[Serializable]
	internal readonly struct SerializedTileset : IMapAsyncSerial<Tileset>
	{
		[JsonInclude]
		public readonly string tilesetName;
		[JsonInclude]
		public readonly IReadOnlyList<SerializedTile> tileData;
		[JsonInclude]
		public readonly int tileWidth;
		[JsonInclude]
		public readonly int tileHeight;

		public bool IsDeserializable => false;

		[JsonConstructor]
		public SerializedTileset(string name, in IEnumerable<SerializedTile> data, int w, int h)
		{
			tilesetName = name;
			tileData = data.ToImmutableArray();
			tileWidth = w;
			tileHeight = h;
		}

		[Pure]
		public readonly async Task<Tileset> Deserialize()
		{
			Tileset tileset = new(tilesetName, tileWidth, tileHeight);
			foreach (var serialized_tile in tileData)
			{
				var tile = await TileManager.LoadTile(serialized_tile);
				Debug.Print("Tile Loaded: " + tile.ToString());

				tileset.Add(serialized_tile.GetID(), tile);
			}

			return tileset;
		}

		[Pure]
		public readonly IEnumerable<SerializedTile> GetData()
		{
			return tileData;
		}
		[Pure]
		public readonly IEnumerator<SerializedTile> GetEnumerator()
		{
			return tileData.GetEnumerator();
		}
	}
}
