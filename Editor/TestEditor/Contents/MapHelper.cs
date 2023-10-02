using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Text.Json;

using Windows.Storage;

using TestEditor.Utility;

namespace TestEditor.Contents
{
	internal static class MapHelper
	{
		public const string mapFileExtension = ".gmap";
		public static readonly JsonSerializerOptions mapLoadSetting;
		public static readonly JsonSerializerOptions mapSaveSetting;

		private static StorageFile lastFile;
		private static Map? loadedMap;
		private static List<Map> storedMaps;

		public static StorageFile LastFile => lastFile;

		static MapHelper()
		{
			lastFile = null;

			loadedMap = null;
			storedMaps = new();
#if !NET5_0_OR_GREATER
			storedMaps.Clear();
#endif

			mapLoadSetting = new JsonSerializerOptions() { PropertyNameCaseInsensitive = true };
			mapSaveSetting = new() { WriteIndented = true };
		}
		public static async Task<Map?> LoadMap(StorageFile file)
		{
			if (file is null)
			{
				ErrorHelper.RaiseMissingArgumentError(nameof(file));
			}

			if (!file.IsAvailable)
			{
				Debug.WriteLine($"Not available file '{file.Name}'");
				return null;
			}

			var json = await File.ReadAllTextAsync(file.Path);
			if (json is null || 0 == json.Length)
			{
				Debug.Print("Empty file");
				return null;
			}

			try
			{
				var map = JsonSerializer.Deserialize<Map?>(json, mapLoadSetting);

				if (map is Map gmap)
				{
					loadedMap = gmap;
					storedMaps.Add(gmap);

					return gmap;
				}
			}
			catch (JsonException e)
			{
				Debug.Print("JsonException: {0}", e.Message);
			}
			catch (Exception e)
			{
				Debug.Print("Exception when reading map {0}: {0}", e.GetType(), e.Message);
			}

			return null;
		}
		public static Task SaveMap(in Map? map, in StorageFolder dest)
		{
			return SaveMap(map, string.Format(null, "{0}{1}{2}", dest.Path, map?.Name, GetMapExtension()));
		}
		public static Task SaveMap(in Map? map, in StorageFile filepath)
		{
			return SaveMap(map, filepath.Path);
		}
		public static Task SaveMap(in Map? map, in string filepath)
		{
			if (filepath is null)
			{
				ErrorHelper.RaiseMissingArgumentError(nameof(filepath));
			}

			if (map is Map gmap)
			{
				var serial = gmap.Serialize();
				try
				{
					if (serial is string contents)
					{
						return File.WriteAllTextAsync(filepath, contents);
					}
				}
				catch
				{
					// Do nothing
				}
			}
			else
			{
				ErrorHelper.RaiseMissingArgumentError(nameof(map));
			}

			return null;
		}
		public static void MemoLastFile(in StorageFile file)
		{
			lastFile = file;
		}
		public static string GetMapExtension() => mapFileExtension;
		public static List<Map> GetMaps() => storedMaps;

	}
}
