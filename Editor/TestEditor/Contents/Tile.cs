using Microsoft.Graphics.Canvas;

namespace TestEditor.Contents
{
	[Serializable]
	internal readonly struct Tile
	{
		public string ImageFile { get; }
		public CanvasBitmap Source { get; }

		public Tile(string filepath, CanvasBitmap source)
		{
			ImageFile = filepath;
			Source = source;
		}

		public static async Task<Tile> LoadTile(string filepath)
		{
			var bitmap = await CanvasBitmap.LoadAsync(CanvasDevice.GetSharedDevice(), filepath);

			return new Tile(filepath, bitmap);
		}
		public static Task<Tile> LoadTile(SerializedTile tile)
		{
			return LoadTile(tile.GetFilePath());
		}
	}
}
