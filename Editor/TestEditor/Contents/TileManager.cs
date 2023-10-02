using Microsoft.Graphics.Canvas;

namespace TestEditor.Contents
{
	internal class TileManager
	{

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
