using System.Diagnostics;
using System.Diagnostics.CodeAnalysis;
using System.Runtime.CompilerServices;
using System.Text.Json;

using Windows.Storage;

namespace TestEditor
{
	internal static class MapHelper
	{
		internal const string mapFileExtension = ".gmap";
		internal static readonly JsonSerializerOptions mapWriteSetting = new()
		{
			WriteIndented = true,
			IncludeFields = true,
			DefaultIgnoreCondition = System.Text.Json.Serialization.JsonIgnoreCondition.WhenWritingDefault,
			IgnoreReadOnlyProperties = true,
			IgnoreReadOnlyFields = true,
		};

		internal static StorageFile lastFile;
		internal static Map? loadedMap;
		internal static List<Map> storedMaps;

		public static StorageFile LastFile => lastFile;

		static MapHelper()
		{
			lastFile = null;

			loadedMap = null;
			storedMaps = new();
#if !NET5_0_OR_GREATER
			storedMaps.Clear();
#endif
		}

		[Discardable]
		public static bool LoadMap(StorageFile file)
		{
			if (file is null)
			{
				throw new ArgumentNullException(nameof(file));
			}

			if (!file.IsAvailable)
			{
				Debug.WriteLine($"Not available file '{file.Name}'");
				return false;
			}

			var json = File.ReadAllText(file.Path);
			if (json is null || 0 == json.Length)
			{
				Debug.Print("Empty file");
				return false;
			}

			try
			{
				var map = JsonSerializer.Deserialize<Map?>(json);

				if (map is Map gmap)
				{
					loadedMap = gmap;
					storedMaps.Add(gmap);

					return true;
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

			return false;
		}
		[Discardable]
		public static bool SaveMap(Map? map, StorageFolder dest)
		{
			return SaveMap(map, string.Format(null, "{0}{1}{2}", dest.Path, map?.myName, GetMapExtension()));
		}
		public static bool SaveMap(Map? map, StorageFile filepath)
		{
			return SaveMap(map, filepath.Path);
		}
		public static bool SaveMap(Map? map, string filepath)
		{
			if (filepath is null)
			{
				throw new ArgumentNullException(nameof(filepath));
			}

			if (map is Map gmap)
			{
				var serial = gmap.Serialize();
				try
				{
					if (serial is string contents)
					{
						File.WriteAllText(filepath, contents);

						return true;
					}
				}
				catch
				{
					// Do nothing
				}
			}
			else
			{
				throw new ArgumentNullException(nameof(map));
			}

			return false;
		}
		public static void MemoLastFile(StorageFile file)
		{
			lastFile = file;
		}
		public static string GetMapExtension() => mapFileExtension;
		public static List<Map> GetMaps() => storedMaps;

		[DoesNotReturn]
		private static void ThrowMissingArgumentError(string paramname)
		{
			throw new ArgumentNullException(paramname);
		}
	}
}
