﻿using System.Diagnostics;
using System.Diagnostics.Contracts;

namespace TestEditor.Contents
{
	internal class Tileset : IMapEntity<SerializedTileset>
	{
		private readonly Dictionary<int, Tile> tileData;
		private readonly int tileWidth;
		private readonly int tileHeight;

		private Tileset()
		{
			tileData = new();
			tileWidth = 0;
			tileHeight = 0;
		}
		public Tileset(in SerializedTileset serialized_tileset) : this()
		{
			Load(serialized_tileset);
			tileWidth = serialized_tileset.tileWidth;
			tileHeight = serialized_tileset.tileHeight;
		}

		public void Load(SerializedTileset serialized_tileset)
		{
			foreach (var serialized_tile in serialized_tileset)
			{
				var task = TileManager.LoadTile(serialized_tile);
				task.RunSynchronously();

				var tile = task.Result;
				Debug.Print("Tile Loaded: " + tile.ToString());
				tileData.Add(serialized_tile.GetID(), tile);
			}
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
