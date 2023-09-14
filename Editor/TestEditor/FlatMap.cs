using System.Collections;
using System.Diagnostics.CodeAnalysis;
using System.Runtime.Serialization;

namespace TestEditor
{
	internal class FlatMap<T, V>
		: IDictionary<T, V>, IReadOnlyDictionary<T, V>, ISerializable, IDeserializationCallback
		where T : notnull
	{
		public List<KeyValuePair<T, V>> myData;

		public int Count => throw new NotImplementedException();
		public bool IsReadOnly => throw new NotImplementedException();
		public ICollection<T> Keys => throw new NotImplementedException();
		public ICollection<V> Values => throw new NotImplementedException();
		IEnumerable<T> IReadOnlyDictionary<T, V>.Keys => throw new NotImplementedException();
		IEnumerable<V> IReadOnlyDictionary<T, V>.Values => throw new NotImplementedException();

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
		public V this[T key]
		{
			get => throw new NotImplementedException();
			set => throw new NotImplementedException();
		}
		IEnumerator IEnumerable.GetEnumerator()
		{
			throw new NotImplementedException();
		}
		public void GetObjectData(SerializationInfo info, StreamingContext context)
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
		public void OnDeserialization(object sender)
		{
			throw new NotImplementedException();
		}
	}
}
