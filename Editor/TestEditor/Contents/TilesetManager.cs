using System.Collections;
using System.Collections.Concurrent;
using System.Diagnostics.CodeAnalysis;

namespace TestEditor.Contents
{
	internal static class TilesetManager
	{
		private static readonly ConcurrentDictionary<string, Tileset> managedTilesets;

		public static ICollection<string> Keys => managedTilesets.Keys;
		public static ICollection<Tileset> Values => managedTilesets.Values;
		public static int Count => managedTilesets.Count;
		public static bool IsReadOnly => ((ICollection<KeyValuePair<string, Tileset>>) managedTilesets).IsReadOnly;

		static TilesetManager()
		{
			managedTilesets = new();
		}

		public static void Add(string key, Tileset value)
		{
			managedTilesets.AddOrUpdate(key
				, (_) => value
				, (_, v) => value);
		}
		public static void Add(KeyValuePair<string, Tileset> item)
		{
			Add(item.Key, item.Value);
		}
		public static bool TryRemove(string key, out Tileset tileset)
		{
			return managedTilesets.Remove(key, out tileset);
		}
		public static bool TryRemove(string key)
		{
			return managedTilesets.Remove(key, out var _);
		}
		public static bool Remove(KeyValuePair<string, Tileset> item)
		{
			return ((ICollection<KeyValuePair<string, Tileset>>) managedTilesets).Remove(item);
		}
		public static void Clear()
		{
			managedTilesets.Clear();
		}
		public static bool TryGetValue(string key, [MaybeNullWhen(false)] out Tileset value)
		{
			return managedTilesets.TryGetValue(key, out value);
		}

		public static IEnumerator<KeyValuePair<string, Tileset>> GetEnumerator()
		{
			return managedTilesets.GetEnumerator();
		}

		public static bool Contains(KeyValuePair<string, Tileset> item)
		{
			return managedTilesets.Contains(item);
		}
		public static bool ContainsKey(string key)
		{
			return managedTilesets.ContainsKey(key);
		}
	}
}
