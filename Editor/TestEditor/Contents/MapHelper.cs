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

		private static Map? loadedMap;
		private static List<Map> storedMaps;

		public static string MapExtension => mapFileExtension;
		public static StorageFile LastFile { get; private set; }
		public static List<Map> Maps => storedMaps;
		public static JsonSerializerOptions MapLoadSetting { get; }
		public static JsonSerializerOptions MapSaveSetting { get; }

		static MapHelper()
		{
			loadedMap = null;
			storedMaps = new();
#if !NET5_0_OR_GREATER
			storedMaps.Clear();
#endif
			LastFile = null;

			MapLoadSetting = new JsonSerializerOptions() { PropertyNameCaseInsensitive = true };
			MapSaveSetting = new() { WriteIndented = true };
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
				var map = JsonSerializer.Deserialize<Map?>(json, MapLoadSetting);

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
			return SaveMap(map, string.Format(null, "{0}{1}{2}", dest.Path, map?.Name, MapExtension));
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

			if (map is Map gamemap)
			{
				var serialized_map = gamemap.Serialize();
				try
				{
					if (serialized_map.ToString() is string contents)
					{
						return File.WriteAllTextAsync(filepath, contents);
					}
				}
				catch
				{
					// Do nothing
					Debug.Print($"An error occured in SaveMap(map, {filepath})");
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
			LastFile = file;
		}
	}
}
