using System.Collections.Immutable;
using System.Diagnostics.Contracts;
using System.Text.Json.Serialization;

namespace TestEditor.Contents
{
	[Serializable]
	internal readonly struct SerializedTileset : IMapAsyncSerial<Tileset>
	{
		[JsonInclude]
		public readonly IReadOnlyList<SerializedTile> tileData;
		[JsonInclude]
		public readonly int tileWidth;
		[JsonInclude]
		public readonly int tileHeight;

		[JsonConstructor]
		public SerializedTileset(in IEnumerable<SerializedTile> data, int w, int h)
		{
			tileData = data.ToImmutableArray();
			tileWidth = w;
			tileHeight = h;
		}

		[Pure]
		public readonly Tileset Deserialize()
		{

		}

		[Pure]
		public readonly IEnumerable<SerializedTile> GetData()
		{
			return tileData;
		}
		[Pure]
		public readonly IEnumerator<SerializedTile> GetEnumerator()
		{
			return tileData.GetEnumerator();
		}
	}
}
