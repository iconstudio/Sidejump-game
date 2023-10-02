using System.Collections.Immutable;
using System.Text.Json.Serialization;

namespace TestEditor.Contents
{
	[Serializable]
	internal readonly struct SerializedTileset : IMapSerial<Tileset>
	{
		[JsonInclude]
		public readonly IList<SerializedTile> tileData;
		[JsonInclude]
		public readonly int tileWidth;
		[JsonInclude]
		public readonly int tileHeight;

		[JsonConstructor]
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

		public readonly IEnumerable<SerializedTile> GetData()
		{
			return tileData;
		}
		public readonly IEnumerator<SerializedTile> GetEnumerator()
		{
			return tileData.GetEnumerator();
		}
	}
}
