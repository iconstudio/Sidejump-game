using System.Collections;
using System.Diagnostics.CodeAnalysis;
using System.Diagnostics.Contracts;
using System.Text.Json.Serialization;

namespace TestEditor.Utility
{
	[Serializable]
	public class FlatMap<T, V>
		: IDictionary<T, V>, IReadOnlyDictionary<T, V>
		, IReadOnlyList<KeyValuePair<T, V>>
		where T : notnull, IEquatable<T>
		where V : IEquatable<V>
	{
		[JsonInclude]
		private List<KeyValuePair<T, V>> myData = new();
		[JsonIgnore]
		private static readonly KeyValuePairComparer myComparer = new();
		[JsonIgnore]
		public static readonly bool isSortable = typeof(IComparable<T>).IsAssignableFrom(typeof(T));

		[JsonIgnore]
		[Pure]
		public int Count => myData.Count;
		[JsonIgnore]
		[Pure]
		public bool IsReadOnly => false;
		[JsonIgnore]
		public ICollection<T> Keys => myData.Select(x => x.Key).ToList();
		[JsonIgnore]
		public ICollection<V> Values => myData.Select(x => x.Value).ToList();
		[JsonIgnore]
		IEnumerable<T> IReadOnlyDictionary<T, V>.Keys => myData.Select(x => x.Key).ToList();
		[JsonIgnore]
		IEnumerable<V> IReadOnlyDictionary<T, V>.Values => myData.Select(x => x.Value).ToList();

		public void Add(T key, V value)
		{
			myData.Add(new(key, value));

			_Sort();
		}
		public void Add(KeyValuePair<T, V> item)
		{
			myData.Add(item);

			_Sort();
		}
		public IEnumerator<KeyValuePair<T, V>> GetEnumerator() => myData.GetEnumerator();
		IEnumerator IEnumerable.GetEnumerator() => myData.GetEnumerator();
		[Pure]
		public bool TryGetValue(T key, [MaybeNullWhen(false)] out V value)
		{
			foreach (var pair in myData)
			{
				if (pair.Key.Equals(key))
				{
					value = pair.Value;
					return true;
				}
			}

			value = default;
			return false;
		}
		/// <returns><typeparamref name="V"/>'s value by <paramref name="key"/></returns>
		/// <exception cref="KeyNotFoundException"></exception>
		public V this[T key]
		{
			get
			{
				if (isSortable)
				{
					KeyValuePair<T, V> temp_pair = new(key, default);
					int search = myData.BinarySearch(temp_pair);
					if (0 < search)
					{
						return myData[search].Value;
					}
				}
				else
				{
					foreach (var pair in myData)
					{
						if (pair.Key.Equals(key))
						{
							return pair.Value;
						}
					}
				}

				throw new KeyNotFoundException(nameof(key));
			}

			set
			{
				if (isSortable)
				{
					KeyValuePair<T, V> temp_pair = new(key, default);
					var search = myData.BinarySearch(temp_pair, myComparer);
					if (search < 0)
					{
						myData.Insert(~search, temp_pair);
					}
					else
					{
						myData[search] = KeyValuePair.Create(key, value);
					}
				}
				else
				{
					for (var i = 0; i < Count; ++i)
					{
						var pair = myData[i];
						if (pair.Key.Equals(key))
						{
							myData[i] = KeyValuePair.Create(key, value);
							return;
						}
					}

					Add(key, value);
				}
			}
		}
		KeyValuePair<T, V> IReadOnlyList<KeyValuePair<T, V>>.this[int index] => ((IReadOnlyList<KeyValuePair<T, V>>)myData)[index];
		public bool Remove(T key)
		{
			return 0 < myData.RemoveAll((pair) => pair.Key.Equals(key));
		}
		public bool Remove(KeyValuePair<T, V> item) => myData.Remove(item);
		public void Clear() => myData.Clear();
		[Pure]
		public bool Contains(KeyValuePair<T, V> item) => myData.Contains(item);
		[Pure]
		public bool ContainsKey(T key) => myData.Any((pair) => pair.Key.Equals(key));
		public void CopyTo(KeyValuePair<T, V>[] array, int arrayIndex) => myData.CopyTo(array, arrayIndex);

		private void _Sort()
		{
			if (isSortable)
			{
				myData.Sort((lhs, rhs) => ((IComparable<T>)lhs.Key).CompareTo(rhs.Key));
			}
		}

		private class KeyValuePairComparer : IComparer<KeyValuePair<T, V>>
		{
			[Pure]
			public int Compare(KeyValuePair<T, V> lhs, KeyValuePair<T, V> rhs)
			{
				return ((IComparable<T>)lhs.Key).CompareTo(rhs.Key);
			}
		}
	}
}
