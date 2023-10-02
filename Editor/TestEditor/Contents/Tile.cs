using Microsoft.Graphics.Canvas;

namespace TestEditor.Contents
{
	[Serializable]
	internal readonly struct Tile
	{
		public readonly string ImageFile { get; }
		public readonly CanvasBitmap Source { get; }

		internal Tile(string filepath, CanvasBitmap source)
		{
			ImageFile = filepath;
			Source = source;
		}
	}
}
