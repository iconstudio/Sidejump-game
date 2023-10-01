using System.Diagnostics.Contracts;

namespace TestEditor.Contents
{
	internal ref struct SerializedTile
	{
		private string tileImageFile;

		public SerializedTile()
		{
			tileImageFile = null;
		}
		public SerializedTile(in SerializedTile other)
		{
			tileImageFile = other.tileImageFile;
		}
		public SerializedTile(SerializedTile other)
		{
			tileImageFile = other.tileImageFile;
		}
		public SerializedTile(in string filepath)
		{
			tileImageFile = filepath;
		}
		public SerializedTile(string filepath)
		{
			tileImageFile = filepath;
		}

		public readonly string GetFilePath() => tileImageFile;

		[Pure]
		public readonly bool Equals(SerializedTile other)
		{
			return tileImageFile == other.tileImageFile;
		}
		[Pure]
		public readonly override int GetHashCode()
		{
			return tileImageFile.GetHashCode();
		}
	}
}
