using System.Diagnostics.Contracts;

namespace TestEditor.Contents
{
	internal struct SerializedMap
		: IEquatable<SerializedMap>, IMapSerial<Map>
	{
		public bool IsDeserializable => false;

		public Map Deserialize()
		{
			throw new NotImplementedException();
		}

		[Pure]
		public readonly bool Equals(SerializedMap other)
		{
			throw new NotImplementedException();
		}
		[Pure]
		public readonly override bool Equals(object obj)
		{
			return obj is SerializedMap other && Equals(other);
		}
		[Pure]
		public readonly override int GetHashCode()
		{
			throw new NotImplementedException();
		}
	}
}
