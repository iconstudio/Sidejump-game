using System.Diagnostics.Contracts;
using System.Text.Json.Serialization;

namespace TestEditor.Contents
{
	[Serializable]
	internal struct Tile
	{
		[JsonInclude] public int id;
		[JsonInclude] public int x;
		[JsonInclude] public int y;

		public Tile() : this(0, 0, 0)
		{ }
		[JsonConstructor]
		public Tile(int tid, int tx, int ty)
		{
			id = tid;
			x = tx;
			y = ty;
		}

		[Pure]
		public static Tile Create(int tid, int tx, int ty)
		{
			return new Tile()
			{
				id = tid,
				x = tx,
				y = ty
			};
		}
	}
}
