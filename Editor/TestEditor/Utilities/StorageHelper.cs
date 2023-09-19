using Windows.Foundation;
using Windows.Storage;

namespace TestEditor.Utility
{
    internal static class StorageHelper
    {
        public static async
            Task<Stream>
            ReadFile(StorageFile file)
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
            var file = await ftask ?? null;
            if (file is not null)
            {
                return await file.OpenStreamForReadAsync();
            }

            return null;
        }
        public static async
            Task<Stream>
            WriteFile(StorageFile file)
        {
            if (file is not null)
            {
                return await file.OpenStreamForWriteAsync();
            }

            return null;
        }
        public static async
            Task<Stream>
            WriteFile(IAsyncOperation<StorageFile> ftask)
        {
            var file = await ftask ?? null;
            if (file is not null)
            {
                return await file.OpenStreamForWriteAsync();
            }

            return null;
        }
    }
}
