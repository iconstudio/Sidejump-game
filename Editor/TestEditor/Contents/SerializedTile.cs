using System.Diagnostics.Contracts;

using Windows.Storage;

namespace TestEditor.Contents
{
	internal struct SerializedTile : IEquatable<SerializedTile>
	{
		private StorageFile tileImageFile;

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
		public SerializedTile(in StorageFile filepath)
		{
			tileImageFile = filepath;
		}
		public SerializedTile(StorageFile filepath)
		{
			tileImageFile = filepath;
		}

		public readonly StorageFile GetFilePath() => tileImageFile;

		[Pure]
		public readonly bool Equals(SerializedTile other)
		{
			return tileImageFile == other.tileImageFile;
		}
		[Pure]
		public readonly override bool Equals(object obj)
		{
			return obj is SerializedTile other && Equals(other);
		}
		[Pure]
		public readonly override int GetHashCode()
		{
			return tileImageFile.GetHashCode();
		}
	}
}
