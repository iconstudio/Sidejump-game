namespace TestEditor.Contents
{
	internal ref struct SerializedTileset
	{
		public List<KeyValuePair<int, string>> tileData;
		public int tileWidth;
		public int tileHeight;

		public SerializedTileset()
		{
			tileData = new();
			tileWidth = 0;
			tileHeight = 0;
		}

		public readonly void Add(in int id, in string tile)
		{
			tileData.Add(new(id, tile));
		}
	}
}
