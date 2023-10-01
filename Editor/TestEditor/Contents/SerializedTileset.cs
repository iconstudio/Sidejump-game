using System.Collections.Immutable;

namespace TestEditor.Contents
{
	[Serializable]
	internal readonly ref struct SerializedTileset
	{
		public readonly IList<SerializedTile> tileData;
		public readonly int tileWidth;
		public readonly int tileHeight;

		public SerializedTileset(IList<SerializedTile> data, int w, int h)
		{
			tileData = data;
			tileWidth = w;
			tileHeight = h;
		}
		public SerializedTileset(in IEnumerable<SerializedTile> data, int w, int h)
		{
			tileData = data.ToImmutableArray();
			tileWidth = w;
			tileHeight = h;
		}
	}
}
