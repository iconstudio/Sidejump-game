using System.Drawing;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace TestEditor.Contents
{
	[Serializable]
	internal struct Map : IMapEntity<SerializedMap>
	{
		[JsonIgnore] public static Map EmptyMap { get; }
		[JsonIgnore] internal Tileset myTileset;
		[JsonIgnore] internal Rectangle myResolution;

		[JsonInclude]
		public string Name { readonly get; set; }
		[JsonInclude]
		public string Description { readonly get; set; }
		[JsonInclude]
		public Tileset Tileset
		{
			readonly get => myTileset;
			set => myTileset = value;
		}
		[JsonIgnore]
		public Rectangle Resolution
		{
			readonly get => myResolution;
			set => myResolution = value;
		}
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
		public int HorizontalTiles { readonly get; set; }
		[JsonInclude]
		public int VerticalTiles { readonly get; set; }
		public bool IsDeserializable => false;

		static Map()
		{
			EmptyMap = new()
			{
				myResolution = Rectangle.Empty,
				myTileset = null,
				Name = "Empty Map",
				Description = "",
				HorizontalTiles = 0,
				VerticalTiles = 0,
			};
		}
		public Map() : this("Empty Map", null)
		{ }
		public Map(in string name) : this(name, null)
		{ }
		public Map(in string name, in Tileset tileset)
		{
			myResolution = new();
			myTileset = tileset;
			Name = name;
			Description = "";
			HorizontalTiles = 0;
			VerticalTiles = 0;
		}

		public void SetTilesCount(int h, int v)
		{
			HorizontalTiles = h;
			VerticalTiles = v;

			if (myTileset is not null)
			{
				Width = myTileset.TileWidth * h;
				Height = myTileset.TileHeight * v;
			}
		}
		public readonly string Serialize()
		{
			return JsonSerializer.Serialize(this, MapHelper.mapSaveSetting);
		}
		SerializedMap IMapEntity<SerializedMap>.Serialize()
		{
			throw new NotImplementedException();
		}
	}
}
