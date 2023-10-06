using System.Diagnostics.Contracts;
using System.Numerics;

using Microsoft.Graphics.Canvas;

using Windows.Foundation;

namespace TestEditor.Contents
{
	[Serializable]
	public readonly struct TileImage
		: IMapEntity<SerializedTileImage, int>, IEquatable<TileImage>
	{
		public readonly string ImageFile { get; }
		public readonly CanvasBitmap Source { get; }
		public readonly Rect Bounds => Source?.Bounds ?? Rect.Empty;
		public bool IsDeserializable => false;

		public TileImage(string filepath, CanvasBitmap source)
		{
			ImageFile = filepath;
			Source = source;
		}

		[Pure]
		public readonly void Draw(CanvasDrawingSession context)
		{
			context.DrawImage(Source);
		}
		[Pure]
		public readonly void Draw(CanvasDrawingSession context, in Vector2 position)
		{
			context.DrawImage(Source, position);
		}
		[Pure]
		public readonly void Draw(CanvasDrawingSession context, in float x, in float y)
		{
			context.DrawImage(Source, x, y);
		}
		[Pure]
		public readonly void Draw(CanvasDrawingSession context, in Vector2 position, in float opacity)
		{
			context.DrawImage(Source, position, Bounds, opacity);
		}
		[Pure]
		public readonly void Draw(CanvasDrawingSession context, in float x, in float y, in float opacity)
		{
			context.DrawImage(Source, x, y, Bounds, opacity);
		}
		[Pure]
		public readonly void DrawPart(CanvasDrawingSession context, in Rect bound)
		{
			context.DrawImage(Source, bound);
		}
		[Pure]
		public readonly void DrawPart(CanvasDrawingSession context, in Vector2 position, in Rect bound)
		{
			context.DrawImage(Source, position, bound);
		}
		[Pure]
		public readonly void DrawPart(CanvasDrawingSession context, in float x, in float y, in Rect bound)
		{
			context.DrawImage(Source, x, y, bound);
		}
		[Pure]
		public readonly void DrawPart(CanvasDrawingSession context, in Vector2 position, in Rect bound, in float opacity)
		{
			context.DrawImage(Source, position, bound, opacity);
		}
		[Pure]
		public readonly void DrawPart(CanvasDrawingSession context, in float x, in float y, in Rect bound, in float opacity)
		{
			context.DrawImage(Source, x, y, bound, opacity);
		}
		[Pure]
		public readonly void DrawInterpolated(CanvasDrawingSession context, in Vector2 position, in float opacity, in CanvasImageInterpolation interpolation)
		{
			context.DrawImage(Source, position, Bounds, opacity, interpolation);
		}
		[Pure]
		public readonly void DrawInterpolated(CanvasDrawingSession context, in float x, in float y, in float opacity, in CanvasImageInterpolation interpolation)
		{
			context.DrawImage(Source, x, y, Bounds, opacity, interpolation);
		}
		[Pure]
		public readonly SerializedTileImage Serialize(int id)
		{
			return new(id, ImageFile);
		}

		[Pure]
		public readonly bool Equals(TileImage other)
		{
			return ImageFile == other.ImageFile && Source.Equals(other.Source);
		}
		[Pure]
		public readonly override bool Equals(object obj)
		{
			return obj is TileImage other && Equals(other);
		}
		[Pure]
		public readonly override int GetHashCode()
		{
			return ImageFile.GetHashCode();
		}

		[Pure]
		public static bool operator ==(TileImage lhs, TileImage rhs)
		{
			return lhs.Equals(rhs);
		}
		[Pure]
		public static bool operator !=(TileImage lhs, TileImage rhs)
		{
			return !lhs.Equals(rhs);
		}
	}
}
