namespace TestEditor.Contents
{
	internal class Tileset
	{
		private Dictionary<int,> tileData;

		public Tileset()
		{
		}
		public Tileset(in SerializedTileset data)
		{
		}
		public Tileset(SerializedTileset data)
		{
		}

		public SerializedTileset Serialize()
		{
			return new();
		}
	}
}
