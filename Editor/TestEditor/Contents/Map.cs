using System.Diagnostics.Contracts;
using System.Drawing;
using System.Text.Json;

namespace TestEditor.Contents
{
	[Serializable]
	internal class Map : IMapEntity<SerializedMap>
	{
		internal Tileset myTileset;
		internal Rectangle myResolution;
		public static Map EmptyMap { get; }

		public Tileset Tileset
		{
			get => myTileset;
			set => myTileset = value;
		}
		public string Name { get; set; }
		public string Description { get; set; }
		public Rectangle Resolution
		{
			get => myResolution;
			set => myResolution = value;
		}
		public int X
		{
			get => myResolution.X;
			set => myResolution.X = value;
		}
		public int Y
		{
			get => myResolution.Y;
			set => myResolution.Y = value;
		}
		public int Width
		{
			get => myResolution.Width;
			set => myResolution.Width = value;
		}
		public int Height
		{
			get => myResolution.Height;
			set => myResolution.Height = value;
		}
		public List<Tile> Tiles { get; set; }
		public int HorizontalTiles { get; set; }
		public int VerticalTiles { get; set; }
		public bool IsDeserializable => false;

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

			Tiles.EnsureCapacity(1200);
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
		public SerializedMap Serialize()
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
