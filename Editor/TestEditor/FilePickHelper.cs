using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Windows.Storage;
using Windows.Storage.Pickers;

namespace TestEditor
{
	internal static class FilePickHelper
	{
		public static async Task<StorageFile> OpenSavePicker(Window window)
		{
			FileSavePicker picker = new();
			picker.FileTypeChoices.Add("Map File", new List<string>() { ".gmap" });
			picker.FileTypeChoices.Add("Archieved Map File", new List<string>() { ".zip" });

			var hWnd = WinRT.Interop.WindowNative.GetWindowHandle(window);
			WinRT.Interop.InitializeWithWindow.Initialize(picker, hWnd);

			return await picker.PickSaveFileAsync();
		}
		public static async Task<StorageFile> OpenLoadPicker(Window window)
		{
			FileOpenPicker picker = new()
			{
				ViewMode = PickerViewMode.Thumbnail
			};
			picker.FileTypeFilter.Add(".gmap");

			var hWnd = WinRT.Interop.WindowNative.GetWindowHandle(window);
			WinRT.Interop.InitializeWithWindow.Initialize(picker, hWnd);

			return await picker.PickSingleFileAsync();
		}
	}
}
