using Windows.Storage;

namespace TestEditor
{
	internal static class MapStorage
	{
		internal static StorageFile lastFile;
		internal static readonly string mapFileExtension = ".gmap";
		internal static List<Map> storedMaps = new();

		public static string GetMapExtension() => mapFileExtension;
		public static void MemoLastFile(StorageFile file)
		{
			lastFile = file;
		}
		public static List<Map> GetMaps() => storedMaps;
	}
}
