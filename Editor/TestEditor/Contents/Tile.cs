using System.Diagnostics.Contracts;
using System.Text.Json.Serialization;

namespace TestEditor.Contents
{
	[Serializable]
	public struct Tile
	{
		[JsonInclude] public int Id { get; set; }
		[JsonInclude] public int X { get; set; }
		[JsonInclude] public int Y { get; set; }

		public Tile() : this(0, 0, 0)
		{ }
		[JsonConstructor]
		public Tile(int tid, int tx, int ty)
		{
			Id = tid;
			X = tx;
			Y = ty;
		}

		[Pure]
		public static Tile Create(int tid, int tx, int ty)
		{
			return new Tile()
			{
				Id = tid,
				X = tx,
				Y = ty
			};
		}
	}
}
