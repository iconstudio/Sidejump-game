using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Windows.Foundation;
using Windows.Storage;
using Windows.Storage.Pickers;
using Windows.Storage.Streams;

namespace TestEditor
{
	internal static class FilePickHelper
	{
		public static IAsyncOperation<StorageFile> OpenLoadPicker(Window window)
		{
			FileOpenPicker picker = new()
			{
				ViewMode = PickerViewMode.Thumbnail
			};
			picker.FileTypeFilter.Clear();
			picker.FileTypeFilter.Add(".gmap");

			var hwnd = WinRT.Interop.WindowNative.GetWindowHandle(window);
			WinRT.Interop.InitializeWithWindow.Initialize(picker, hwnd);

			return picker.PickSingleFileAsync();
		}
		public static IAsyncOperation<StorageFile> OpenSavePicker(Window window)
		{
			FileSavePicker picker = new();
			picker.FileTypeChoices.Clear();
			picker.FileTypeChoices.Add("Map File", new List<string>() { ".gmap" });
			//picker.FileTypeChoices.Add("Archieved Map File", new List<string>() { ".zip" });

			var hwnd = WinRT.Interop.WindowNative.GetWindowHandle(window);
			WinRT.Interop.InitializeWithWindow.Initialize(picker, hwnd);

			return picker.PickSaveFileAsync();
		}
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
