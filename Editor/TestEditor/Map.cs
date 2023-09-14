using System.Drawing;
using System.Text.Json;

namespace TestEditor
{
	[Serializable]
	internal class Map
	{
		// info
		public string myName;
		public string myDescription;
		// resolution
		public Rectangle myResolution;
		// tiles
		public Tileset myTileset;
		public uint tilesHrCount, tilesVtCount;

		public int X { get => myResolution.X; private set => myResolution.X = value; }
		public int Y { get => myResolution.Y; private set => myResolution.Y = value; }
		public int Width { get => myResolution.Width; private set => myResolution.Width = value; }
		public int Height { get => myResolution.Height; private set => myResolution.Height = value; }

		public string Serialize()
		{
			var options = new JsonSerializerOptions
			{
				WriteIndented = true,
				IgnoreReadOnlyFields = true,
			};

			return JsonSerializer.Serialize(this, options);
		}
	}
}
