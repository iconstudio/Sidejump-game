using System.Diagnostics.Contracts;
using System.Drawing;
using System.Text.Json;

namespace TestEditor.Contents
{
	[Serializable]
	internal struct Map : IMapEntity<SerializedMap>
	{
		internal Tileset myTileset;
		internal Rectangle myResolution;
		public static Map EmptyMap { get; }

		public Tileset Tileset
		{
			readonly get => myTileset;
			set => myTileset = value;
		}
		public string Name { readonly get; set; }
		public string Description { readonly get; set; }
		public Rectangle Resolution
		{
			readonly get => myResolution;
			set => myResolution = value;
		}
		public int X
		{
			readonly get => myResolution.X; set => myResolution.X = value;
		}
		public int Y
		{
			readonly get => myResolution.Y; set => myResolution.Y = value;
		}
		public int Width
		{
			readonly get => myResolution.Width; set => myResolution.Width = value;
		}
		public int Height
		{
			readonly get => myResolution.Height; set => myResolution.Height = value;
		}
		public List<Tile> Tiles { readonly get; set; }
		public int HorizontalTiles { readonly get; set; }
		public int VerticalTiles { readonly get; set; }
		public readonly bool IsDeserializable => false;

		static Map()
		{
			EmptyMap = new()
			{
				myResolution = Rectangle.Empty,
				myTileset = null,
				Name = "Empty Map",
				Description = "",
				Tiles = null,
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
			Tiles = new();
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
		[Pure]
		public readonly SerializedMap Serialize()
		{
			return new()
			{
				Tileset = Tileset.Serialize(),
				Name = Name,
				Description = Description,
				X = X,
				Y = Y,
				W = Width,
				H = Height,
				HorizontalTiles = HorizontalTiles,
				VerticalTiles = VerticalTiles
			};
		}
	}
}
