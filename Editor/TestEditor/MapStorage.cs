using Windows.Storage;

namespace TestEditor
{
	internal static class MapStorage
	{
		private static StorageFile lastFile;

		private static List<Map> storedMaps = new();
		public static void MemoLastFile(StorageFile file)
		{
			lastFile = file;
		}
		public static List<Map> GetMaps() => storedMaps;
	}
}
