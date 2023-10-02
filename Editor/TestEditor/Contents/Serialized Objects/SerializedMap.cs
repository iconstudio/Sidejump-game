using System.Diagnostics.Contracts;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace TestEditor.Contents
{
	[Serializable]
	internal struct SerializedMap
		: IEquatable<SerializedMap>, IMapSerial<Map>
	{
		[JsonInclude] public string Tileset { get; set; }
		[JsonInclude] public string Name { get; set; }
		[JsonInclude] public string Description { get; set; }
		[JsonInclude] public int X { get; set; }
		[JsonInclude] public int Y { get; set; }
		[JsonInclude] public int W { get; set; }
		[JsonInclude] public int H { get; set; }
		[JsonInclude] public int HorizontalTiles { get; set; }
		[JsonInclude] public int VerticalTiles { get; set; }
		[JsonIgnore] public readonly bool IsDeserializable => false;

		public Map Deserialize()
		{
			throw new NotImplementedException();
		}

		[Pure]
		public override readonly string ToString()
		{
			return JsonSerializer.Serialize(this, MapHelper.mapSaveSetting);
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
