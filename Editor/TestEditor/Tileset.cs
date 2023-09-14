using System.Text.Json.Serialization;

namespace TestEditor
{
	internal class Tileset
	{
		public Dictionary<int, string> tileData;
		public uint tileWidth;
		public uint tileHeight;
	}
}
