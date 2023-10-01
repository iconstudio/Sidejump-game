using System.Diagnostics.Contracts;

using Microsoft.Graphics.Canvas;

using Windows.Storage;

namespace TestEditor.Contents
{
	[Serializable]
	internal class Tile
	{
		public int Id { get; init; }
		public StorageFile ImageFile { get; init; }
		public CanvasBitmap Source { get; private set; }

		[Pure]
		public SerializedTile Serialize()
		{
			return new(Id, ImageFile.Path);
		}
	}
}
