using Microsoft.Graphics.Canvas;
using Microsoft.Graphics.Canvas.UI.Xaml;

using Windows.Storage;

namespace TestEditor.Contents
{
	internal class Tile
	{
		public StorageFile ImageFile { get; init; }
		public CanvasBitmap Source { get; private set; }


		public SerializedTile Serialize()
		{
			return new();
		}
	}
}
