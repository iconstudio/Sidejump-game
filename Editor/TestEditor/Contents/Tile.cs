namespace TestEditor.Contents
{
	internal struct Tile
	{
		public int id;
		public int x;
		public int y;

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
