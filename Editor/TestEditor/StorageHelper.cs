using Windows.Foundation;
using Windows.Storage;

namespace TestEditor
{
	internal static class StorageHelper
	{
		public static async
			Task<Stream>
			TryOpenReadOnlyFile(StorageFile file)
		{
			if (file is not null)
			{
				return await file.OpenStreamForReadAsync();
			}

			return null;
		}
		public static async
			Task<Stream>
			TryOpenReadOnlyFile(IAsyncOperation<StorageFile> ftask)
		{
			var file = await ftask;
			if (file is not null)
			{
				return await file.OpenStreamForReadAsync();
			}

			return null;
		}
		public static async
			Task<Stream>
			TryOpenWriteFile(StorageFile file)
		{
			if (file is not null)
			{
				return await file.OpenStreamForWriteAsync();
			}

			return null;
		}
		public static async
			Task<Stream>
			TryOpenWriteFile(IAsyncOperation<StorageFile> ftask)
		{
			var file = await ftask;
			if (file is not null)
			{
				return await file.OpenStreamForWriteAsync();
			}

			return null;
		}
	}
}
