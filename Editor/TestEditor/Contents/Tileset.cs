using System.Diagnostics;
using System.Diagnostics.Contracts;

namespace TestEditor.Contents
{
	internal class Tileset : IMapEntity<SerializedTileset>
	{
		private readonly Dictionary<int, Tile> tileData;
		private readonly int tileWidth;
		private readonly int tileHeight;

		public Tileset()
		{
			tileData = new();
			tileWidth = 0;
			tileHeight = 0;
		}
		public Tileset(Dictionary<int, Tile> data, int tw, int th)
		{
			tileData = new(data);
			tileWidth = tw;
			tileHeight = th;
		}

		public void Add(int id, Tile tile)
		{
			tileData[id] = tile;
		}

		[Pure]
		public SerializedTileset Serialize()
		{
			List<SerializedTile> serialized_tiles = new();
			serialized_tiles.EnsureCapacity(tileData.Count);

			foreach (var data in tileData)
			{
				var tile = data.Value;
				var serialized = tile.Serialize(data.Key);

				serialized_tiles.Add(serialized);
			}

			return new(serialized_tiles, tileWidth, tileHeight);
		}
	}
}
