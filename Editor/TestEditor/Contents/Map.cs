using System.Drawing;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace TestEditor.Contents
{
	[Serializable]
	internal struct Map
	{
		[JsonIgnore] public static readonly Map emptyMap;
		[JsonIgnore] internal string myName;
		[JsonIgnore] internal string myDescription;
		[JsonIgnore] internal Rectangle myResolution;
		[JsonIgnore] internal SerializedTileset myTileset;
		[JsonIgnore] internal int tilesHrCount, tilesVtCount;

		[JsonInclude]
		public string Name { readonly get => myName; set => myName = value; }
		[JsonInclude]
		public string Description { readonly get => myDescription; set => myDescription = value; }
		[JsonInclude]
		public int X
		{
			readonly get => myResolution.X; set => myResolution.X = value;
		}
		[JsonInclude]
		public int Y
		{
			readonly get => myResolution.Y; set => myResolution.Y = value;
		}
		[JsonInclude]
		public int Width
		{
			readonly get => myResolution.Width; set => myResolution.Width = value;
		}
		[JsonInclude]
		public int Height
		{
			readonly get => myResolution.Height; set => myResolution.Height = value;
		}
		[JsonInclude]
		public int HorizontalTiles
		{
			readonly get => tilesHrCount; set => tilesHrCount = value;
		}
		[JsonInclude]
		public int VerticalTiles
		{
			readonly get => tilesVtCount; set => tilesVtCount = value;
		}
		[JsonInclude]
		public readonly SerializedTileset Tileset => myTileset;
		[JsonIgnore]
		public readonly Rectangle Resolution => myResolution;

		static Map()
		{
			emptyMap = new()
			{
				myName = "Empty Map",
				myDescription = "",
				myResolution = Rectangle.Empty,
				myTileset = null,
				tilesHrCount = 0,
				tilesVtCount = 0,
			};
		}
		public Map() : this("Empty Map", null)
		{ }
		public Map(in string name) : this(name, null)
		{ }
		public Map(in string name, in SerializedTileset tileset)
		{
			myName = name;
			myDescription = "";
			myResolution = new();
			myTileset = (SerializedTileset)tileset.Clone();
			tilesHrCount = 0;
			tilesVtCount = 0;
		}
		public Map(in string name, SerializedTileset tileset)
		{
			myName = name;
			myDescription = "";
			myResolution = new();
			myTileset = tileset;
			tilesHrCount = 0;
			tilesVtCount = 0;
		}

		public void SetTilesCount(int h, int v)
		{
			tilesHrCount = h;
			tilesVtCount = v;

			if (myTileset is not null)
			{
				Width = myTileset.tileWidth * h;
				Height = myTileset.tileHeight * v;
			}
		}
		public readonly string Serialize()
		{
			return JsonSerializer.Serialize(this, MapHelper.mapSaveSetting);
		}
	}
}
