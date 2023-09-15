namespace TestEditor
{
	internal class Tileset
	{
		public FlatMap<int, string> tileData;
		public uint tileWidth;
		public uint tileHeight;

		public Tileset()
		{
			tileData = new();
			tileWidth = 0;
			tileHeight = 0;
		}

		public string this[int tile_id]
		{
			get { return tileData[tile_id]; }
			set { tileData[tile_id] = value; }
		}
	}
}
