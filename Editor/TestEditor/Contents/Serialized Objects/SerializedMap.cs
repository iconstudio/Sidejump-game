using System.Diagnostics.Contracts;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace TestEditor.Contents
{
	[Serializable]
	internal struct SerializedMap : IMapSerial<Map>
	{
		[JsonInclude] public SerializedTileset Tileset { get; set; }
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
			return JsonSerializer.Serialize(this, MapHelper.MapSaveSetting);
		}
	}
}
