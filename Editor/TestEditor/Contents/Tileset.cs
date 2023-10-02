﻿using System.Diagnostics.CodeAnalysis;
using System.Diagnostics.Contracts;

namespace TestEditor.Contents
{
	[Serializable]
	internal class Tileset : IMapEntity<SerializedTileset>
	{
		public string Name { get; set; }
		private Dictionary<int, Tile> TileMap { get; }
		public int TileWidth { [Pure] get; private set; }
		public int TileHeight { [Pure] get; private set; }
		public bool IsDeserializable => false;

		public Tileset([NotNull] string name, int tw, int th)
		{
			Name = name;
			TileMap = new();
			TileWidth = tw;
			TileHeight = th;
		}
		public Tileset([NotNull] string name, [NotNull] Dictionary<int, Tile> data, int tw, int th)
		{
			Name = name;
			TileMap = new(data);
			TileWidth = tw;
			TileHeight = th;
		}

		public void Add(int id, Tile tile)
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
