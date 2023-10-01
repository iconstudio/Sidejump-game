using TestEditor.Utility;

using Windows.Storage;

namespace TestEditor.Contents
{
	internal struct SerializedTileset : ICloneable
	{
		public FlatMap<int, SerializedTile> tileData;
		public int tileWidth;
		public int tileHeight;

		public SerializedTileset()
		{
			tileData = new();
			tileWidth = 0;
			tileHeight = 0;
		}

		public readonly SerializedTile this[in int tile_id]
		{
			get => tileData[tile_id];
			set => tileData[tile_id] = value;
		}
		public void Add(in int id, in SerializedTile tile) => tileData.Add(id, tile);
		public object Clone()
		{
			var result = new SerializedTileset()
			{
				tileWidth = tileWidth,
				tileHeight = tileHeight,
			};

			foreach (var tile in tileData)
			{
				result.tileData.Add(tile);
			}

			return result;
		}
	}
}
