namespace TestEditor
{
	internal static class MapStorage
	{
		private static List<Map> storedMaps = new();

		public static List<Map> GetMaps() => storedMaps;
	}
}
