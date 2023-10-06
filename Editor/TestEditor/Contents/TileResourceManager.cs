using System.Collections.Concurrent;
using System.Diagnostics.CodeAnalysis;

using Microsoft.Graphics.Canvas;

namespace TestEditor.Contents
{
	internal static class TileResourceManager
	{
		private static readonly ConcurrentDictionary<string, TileImage> managedTiles;

		static TileResourceManager()
		{
			managedTiles = new();
		}

		public static async Task<TileImage> LoadTile([NotNull] string filepath)
		{
			if (managedTiles.TryGetValue(filepath, out var existed))
			{
				return existed;
			}

			var bitmap = await CanvasBitmap.LoadAsync(CanvasDevice.GetSharedDevice(), filepath);

			if (bitmap is not null)
			{
				var result = new TileImage(filepath, bitmap);

				return managedTiles.AddOrUpdate(filepath
					, (_) => result
					, (k, _) => throw new FileLoadException(filepath));
			}

			throw new IOException(filepath);
		}
		public static Task<TileImage> LoadTile(SerializedTile tile)
		{
			return LoadTile(tile.GetFilePath());
		}
		public static TileImage? FindTile([NotNull] string filepath)
		{
			if (managedTiles.TryGetValue(filepath, out var tile))
			{
				return tile;
			}

			return null;
		}
	}
}
