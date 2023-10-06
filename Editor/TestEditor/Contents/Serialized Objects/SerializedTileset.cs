using System.Collections.Immutable;
using System.Diagnostics;
using System.Diagnostics.Contracts;
using System.Text.Json.Serialization;

namespace TestEditor.Contents
{
	[Serializable]
	public readonly struct SerializedTileset : IMapAsyncSerial<Tileset>
	{
		[JsonInclude]
		public readonly string Name { get; }
		[JsonInclude]
		public readonly IReadOnlyList<SerializedTileImage> ImageData { get; }
		[JsonInclude]
		public readonly int TileWidth { get; }
		[JsonInclude]
		public readonly int TileHeight { get; }
		public readonly bool IsDeserializable => false;

		[JsonConstructor]
		public SerializedTileset(string name, in IEnumerable<SerializedTileImage> data, int w, int h)
		{
			Name = name;
			ImageData = data.ToImmutableArray();
			TileWidth = w;
			TileHeight = h;
		}

		[Pure]
		public readonly async Task<Tileset> Deserialize()
		{
			Tileset tileset = new(Name, TileWidth, TileHeight);
			foreach (var serialized_tile in ImageData)
			{
				var tile = await TileResourceManager.LoadTile(serialized_tile);
				Debug.Print("TileImage Loaded: " + tile.ToString());

				tileset.Add(serialized_tile.GetID(), tile);
			}

			return tileset;
		}

		[Pure]
		public readonly IEnumerable<SerializedTileImage> GetData()
		{
			return ImageData;
		}
		[Pure]
		public readonly IEnumerator<SerializedTileImage> GetEnumerator()
		{
			return ImageData.GetEnumerator();
		}
	}
}
