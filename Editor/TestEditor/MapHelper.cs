using Windows.Storage;

namespace TestEditor
{
	internal static class MapHelper
	{
		internal const string mapFileExtension = ".gmap";

		internal static StorageFile lastFile;
		internal static List<Map> storedMaps = new();

		public static void MemoLastFile(StorageFile file)
		{
			lastFile = file;
		}
		public static string GetMapExtension() => mapFileExtension;
		public static List<Map> GetMaps() => storedMaps;
	}
}
