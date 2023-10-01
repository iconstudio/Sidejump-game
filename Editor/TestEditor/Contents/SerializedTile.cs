using Windows.Storage;

namespace TestEditor.Contents
{
	internal struct SerializedTile
	{
		public StorageFile tileImageFile;

		public SerializedTile()
		{
			tileImageFile = null;
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
	}
}
