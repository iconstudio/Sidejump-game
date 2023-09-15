﻿using System.Drawing;
using System.Text.Json;

namespace TestEditor
{
	[Serializable]
	internal struct Map
	{
		public static readonly Map emptyMap;

		// info
		public string myName;
		public string myDescription;
		// resolution
		public Rectangle myResolution;
		// tiles
		public Tileset myTileset;
		public int tilesHrCount, tilesVtCount;

		public int X { get => myResolution.X; private set => myResolution.X = value; }
		public int Y { get => myResolution.Y; private set => myResolution.Y = value; }
		public int Width { get => myResolution.Width; private set => myResolution.Width = value; }
		public int Height { get => myResolution.Height; private set => myResolution.Height = value; }

		static Map()
		{
			emptyMap = new()
			{
				myName = "Empty Map",
				myDescription = "",
				myResolution = new(),
				myTileset = null,
				tilesHrCount = 0,
				tilesVtCount = 0,
			};
		}
		public Map() : this("Empty Map")
		{ }
		public Map(string name) : this("Empty Map", null)
		{ }
		public Map(string name, in Tileset tileset)
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
				Width = (myTileset.tileWidth * h);
				Height = (myTileset.tileHeight * v);
			}
		}
		public string Serialize()
		{
			return JsonSerializer.Serialize(this, MapHelper.mapWriteSetting);
		}
	}
}
