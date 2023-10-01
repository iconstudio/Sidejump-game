using Microsoft.Graphics.Canvas;

namespace TestEditor.Contents
{
	[Serializable]
	internal readonly struct Tile
	{
		public string ImageFile { get; }
		public CanvasBitmap Source { get; }
	}
}
