namespace TestEditor
{
	internal class Tileset : ICloneable
	{
		public FlatMap<int, string> tileData;
		public int tileWidth;
		public int tileHeight;

		public Tileset()
		{
			tileData = new();
			tileWidth = 0;
			tileHeight = 0;
		}

		public string this[in int tile_id]
		{
			get { return tileData[tile_id]; }
			set { tileData[tile_id] = value; }
		}
		public void Add(in int id, in string tile) => tileData.Add(id, tile);
		public object Clone()
		{
			var result = new Tileset()
			{
				tileWidth = this.tileWidth,
				tileHeight = this.tileHeight,
			};

			foreach (var tile in tileData)
			{
				result.tileData.Add(tile);
			}

			return result;
		}
	}
}
