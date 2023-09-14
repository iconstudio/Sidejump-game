using System.Diagnostics;
using System.Text.Json;

using Windows.Storage;

namespace TestEditor
{
	internal static class MapHelper
	{
		internal const string mapFileExtension = ".gmap";

		internal static StorageFile lastFile;
		internal static Map loadedMap;
		internal static List<Map> storedMaps = new();

		static MapHelper()
		{
			lastFile = null;
			loadedMap = null;
			storedMaps.Clear();
		}

		public static async void LoadMap(StorageFile file)
		{
			if (file is null)
			{
				throw new ArgumentNullException(nameof(file));
			}

			if (!file.IsAvailable)
			{
				Debug.WriteLine($"Not available file '{file.Name}'");
				return;
			}

			var json = File.ReadAllText(file.Path);
			if (json is not null)
			{
				lastFile = file;

				var map = JsonSerializer.Deserialize<Map>(json);

				if (map is not null)
				{
					loadedMap = map;
					storedMaps.Add(map);
				}
			}
		}
		public static async void SaveMap(Map map, StorageFolder dest)
		{
			SaveMap(map, string.Format(null, "{0} {1} {2}", dest.Path, map.myName, GetMapExtension()));
		}
		public static async void SaveMap(Map map, StorageFile filepath)
		{
			SaveMap(map, filepath.Path);
		}
		public static async void SaveMap(Map map, string filepath)
		{
			if (map is null)
			{
				throw new ArgumentNullException(nameof(map));
			}

			if (filepath is null)
			{
				throw new ArgumentNullException(nameof(filepath));
			}

			//var fstream = File.OpenWrite(filepath);
			var contents = map.Serialize();
			try
			{
				File.WriteAllText(filepath, contents);
			}
			catch
			{
				// Do nothing
			}
		}
		public static void MemoLastFile(StorageFile file)
		{
			lastFile = file;
		}
		public static string GetMapExtension() => mapFileExtension;
		public static List<Map> GetMaps() => storedMaps;
	}
}
