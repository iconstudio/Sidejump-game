using System.Diagnostics.Contracts;

using Microsoft.Graphics.Canvas;

namespace TestEditor.Contents
{
	[Serializable]
	internal readonly struct Tile : IEquatable<Tile>
	{
		public readonly string ImageFile { get; }
		public readonly CanvasBitmap Source { get; }

		public Tile(string filepath, CanvasBitmap source)
		{
			ImageFile = filepath;
			Source = source;
		}

		[Pure]
		public readonly bool Equals(Tile other)
		{
			return ImageFile == other.ImageFile && Source.Equals(other.Source);
		}
		[Pure]
		public readonly override bool Equals(object obj)
		{
			return obj is Tile other && Equals(other);
		}
		[Pure]
		public readonly override int GetHashCode()
		{
			return ImageFile.GetHashCode();
		}

		[Pure]
		public static bool operator ==(Tile lhs, Tile rhs)
		{
			return lhs.Equals(rhs);
		}
		[Pure]
		public static bool operator !=(Tile lhs, Tile rhs)
		{
			return !lhs.Equals(rhs);
		}
	}
}
