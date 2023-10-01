using System.Diagnostics.Contracts;

using Microsoft.Graphics.Canvas;

using Windows.Storage;

namespace TestEditor.Contents
{
	[Serializable]
	internal readonly struct Tile
	{
		public StorageFile ImageFile { get; }
		public CanvasBitmap Source { get; }
	}
}
