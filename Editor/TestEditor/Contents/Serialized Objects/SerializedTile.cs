using System.Diagnostics.Contracts;
using System.Text.Json.Serialization;

namespace TestEditor.Contents
{
	[Serializable]
	internal readonly struct SerializedTile
		: IEquatable<SerializedTile>, IMapSerial<TileImage?>
	{
		[JsonInclude]
		private readonly int tileID;
		[JsonInclude]
		private readonly string tileFile;

		public bool IsDeserializable => false;

		[JsonConstructor]
		public SerializedTile(in int id, in string filepath)
		{
			tileID = id;
			tileFile = filepath;
		}

		[Pure]
		public readonly TileImage? Deserialize()
		{
			return TileManager.FindTile(GetFilePath());
		}

		[Pure]
		public readonly int GetID() => tileID;
		[Pure]
		public readonly string GetFilePath() => tileFile;

		[Pure]
		public readonly bool Equals(SerializedTile other)
		{
			return tileID == other.tileID && tileFile == other.tileFile;
		}
		[Pure]
		public override bool Equals(object obj)
		{
			return obj is SerializedTile other && Equals(other);
		}
		[Pure]
		public readonly override int GetHashCode()
		{
			return tileID.GetHashCode();
		}

		[Pure]
		public static bool operator==(SerializedTile lhs, SerializedTile rhs)
		{
			return lhs.Equals(rhs);
		}
		[Pure]
		public static bool operator !=(SerializedTile lhs, SerializedTile rhs)
		{
			return !lhs.Equals(rhs);
		}
	}
}
