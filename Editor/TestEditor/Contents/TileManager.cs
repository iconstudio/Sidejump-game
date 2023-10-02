using System.Collections.Concurrent;
using System.Diagnostics.CodeAnalysis;

using Microsoft.Graphics.Canvas;

namespace TestEditor.Contents
{
	internal static class TileManager
	{
		private static readonly ConcurrentDictionary<string, Tile> managedTiles;

		static TileManager()
		{
			managedTiles = new();
		}

		public static async Task<Tile> LoadTile([NotNull] string filepath)
		{
			if (managedTiles.TryGetValue(filepath, out var existed))
			{
				return existed;
			}

			var bitmap = await CanvasBitmap.LoadAsync(CanvasDevice.GetSharedDevice(), filepath);

			if (bitmap is not null)
			{
				var result = new Tile(filepath, bitmap);

				return managedTiles.AddOrUpdate(filepath
					, (_) => result
					, (k, _) => throw new FileLoadException(filepath));
			}

			throw new IOException(filepath);
		}
		public static Task<Tile> LoadTile(SerializedTile tile)
		{
			return LoadTile(tile.GetFilePath());
		}
		public static Tile? FindTile([NotNull] string filepath)
		{
			if (managedTiles.TryGetValue(filepath, out var tile))
			{
				return tile;
			}

			return null;
		}
	}
}
