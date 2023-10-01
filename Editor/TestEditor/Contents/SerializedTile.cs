using System.Diagnostics.Contracts;

namespace TestEditor.Contents
{
	[Serializable]
	internal readonly struct SerializedTile : IEquatable<SerializedTile>
	{
		private readonly int tileID;
		private readonly string tileFile;

		public SerializedTile(int id, in string filepath)
		{
			tileID = id;
			tileFile = filepath;
		}
		public SerializedTile(int id, string filepath)
		{
			tileID = id;
			tileFile = filepath;
		}
		public SerializedTile(in SerializedTile other)
		{
			tileID = other.tileID;
			tileFile = other.tileFile;
		}
		public SerializedTile(SerializedTile other)
		{
			tileID = other.tileID;
			tileFile = other.tileFile;
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
