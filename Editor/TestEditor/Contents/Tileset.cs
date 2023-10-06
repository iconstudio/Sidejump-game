using System.Diagnostics.CodeAnalysis;
using System.Diagnostics.Contracts;

namespace TestEditor.Contents
{
	[Serializable]
	internal class Tileset : IMapEntity<SerializedTileset>
	{
		public string Name { [Pure] get; }
		private Dictionary<int, TileImage> TileMap { [Pure] get; }
		public int TileWidth { [Pure] get; }
		public int TileHeight { [Pure] get; }
		public bool IsDeserializable => false;

		public Tileset([NotNull] string name, int tw, int th)
		{
			Name = name;
			TileMap = new();
			TileWidth = tw;
			TileHeight = th;
		}
		public Tileset([NotNull] string name, [NotNull] Dictionary<int, TileImage> data, int tw, int th)
		{
			Name = name;
			TileMap = new(data);
			TileWidth = tw;
			TileHeight = th;
		}

		public void Add(int id, TileImage tile)
		{
			TileMap[id] = tile;
		}

		[Pure]
		public SerializedTileset Serialize()
		{
			List<SerializedTile> serialized_tiles = new();
			serialized_tiles.EnsureCapacity(TileMap.Count);

			foreach (var data in TileMap)
			{
				var tile = data.Value;
				var serialized = tile.Serialize(data.Key);

				serialized_tiles.Add(serialized);
			}

			return new(Name, serialized_tiles, TileWidth, TileHeight);
		}
	}
}
