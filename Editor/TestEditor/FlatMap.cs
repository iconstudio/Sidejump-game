using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestEditor
{
	internal class FlatMap<T, V>
		: IDictionary<T, V> where T : notnull
	{
		public V this[T key] { get => throw new NotImplementedException(); set => throw new NotImplementedException(); }

		public ICollection<T> Keys => throw new NotImplementedException();

		public ICollection<V> Values => throw new NotImplementedException();

		public int Count => throw new NotImplementedException();

		public bool IsReadOnly => throw new NotImplementedException();

		public void Add(T key, V value)
		{
			throw new NotImplementedException();
		}
		public void Add(KeyValuePair<T, V> item)
		{
			throw new NotImplementedException();
		}
		public IEnumerator<KeyValuePair<T, V>> GetEnumerator()
		{
			throw new NotImplementedException();
		}
		public bool TryGetValue(T key, [MaybeNullWhen(false)] out V value)
		{
			throw new NotImplementedException();
		}
		IEnumerator IEnumerable.GetEnumerator()
		{
			throw new NotImplementedException();
		}
		public bool Remove(T key)
		{
			throw new NotImplementedException();
		}
		public bool Remove(KeyValuePair<T, V> item)
		{
			throw new NotImplementedException();
		}
		public void Clear()
		{
			throw new NotImplementedException();
		}
		public bool Contains(KeyValuePair<T, V> item)
		{
			throw new NotImplementedException();
		}
		public bool ContainsKey(T key)
		{
			throw new NotImplementedException();
		}
		public void CopyTo(KeyValuePair<T, V>[] array, int arrayIndex)
		{
			throw new NotImplementedException();
		}
	}
}
