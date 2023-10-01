namespace TestEditor.Contents
{
	internal class Tileset
	{
		private Dictionary<int, Tile> tileData;
		private int tileWidth;
		private int tileHeight;

		public Tileset()
		{
			tileData = new();
			tileWidth = 0;
			tileHeight = 0;
		}
		public Tileset(in SerializedTileset data) : this()
		{
			foreach (var tile in data)
			{
				//tileData.Add(tile.GetID(), tile.)
			}

			tileWidth = data.tileWidth;
			tileHeight = data.tileHeight;
		}

		public SerializedTileset Serialize()
		{
			List<SerializedTile> serialized_tiles = new();
			serialized_tiles.EnsureCapacity(tileData.Count);

			foreach (var data in tileData)
			{
				var tile = data.Value;

				SerializedTile serialized = new(data.Key, tile.ImageFile);

				serialized_tiles.Add(serialized);
			}

			return new(serialized_tiles, tileWidth, tileHeight);
		}
	}
}
