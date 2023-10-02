using System.Diagnostics.Contracts;
using System.Text.Json.Serialization;

namespace TestEditor.Contents
{
	[Serializable]
	internal readonly struct SerializedTile
		: IEquatable<SerializedTile>, IMapSerial<Tile>
	{
		[JsonInclude]
		private readonly int tileID;
		[JsonInclude]
		private readonly string tileFile;

		[JsonConstructor]
		public SerializedTile(in int id, in string filepath)
		{
			tileID = id;
			tileFile = filepath;
		}

		public Tile Deserialize()
		{
			throw new NotImplementedException();
		}
		public readonly int GetID() => tileID;
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
