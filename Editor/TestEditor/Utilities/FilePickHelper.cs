using Windows.Foundation;
using Windows.Storage;
using Windows.Storage.Pickers;
using TestEditor.Editor;
using Windows.Win32.Foundation;

namespace TestEditor.Utility
{
	public static class FilePickHelper
	{
		internal static
			IAsyncOperation<StorageFile>
			OpenLoadPicker(Window window, IEnumerable<string> extentions)
		{
			var handle = WinRT.Interop.WindowNative.GetWindowHandle(window);

			return OpenLoadPicker((HWND) handle, extentions);
		}
		internal static
			IAsyncOperation<StorageFile>
			OpenLoadPicker(Window window, params string[] extentions)
		{
			var handle = WinRT.Interop.WindowNative.GetWindowHandle(window);

			return OpenLoadPicker((HWND) handle, extentions);
		}
		internal static
			IAsyncOperation<StorageFile>
			OpenLoadPicker(HWND hwnd, IEnumerable<string> extentions)
		{
			FileOpenPicker picker = new()
			{
				ViewMode = PickerViewMode.Thumbnail
			};

			picker.FileTypeFilter.Clear();
			foreach (var ext in extentions)
			{
				picker.FileTypeFilter.Add(ext);
			}

			WinRT.Interop.InitializeWithWindow.Initialize(picker, hwnd);

			return picker.PickSingleFileAsync();
		}
		internal static
			IAsyncOperation<StorageFile>
			OpenLoadPicker(HWND hwnd, params string[] extentions)
		{
			FileOpenPicker picker = new()
			{
				ViewMode = PickerViewMode.Thumbnail
			};

			picker.FileTypeFilter.Clear();
			foreach (var ext in extentions)
			{
				picker.FileTypeFilter.Add(ext);
			}

			WinRT.Interop.InitializeWithWindow.Initialize(picker, hwnd);

			return picker.PickSingleFileAsync();
		}
		internal static
			IAsyncOperation<StorageFile>
			OpenSavePicker(Window window)
		{
			FileSavePicker picker = new();
			picker.FileTypeChoices.Clear();
			picker.FileTypeChoices.Add("Map File", new List<string>() { EditorFileHelper.MapExtension });
			//picker.FileTypeChoices.Add("Archieved Map File", new List<string>() { ".zip" });

			var hwnd = WinRT.Interop.WindowNative.GetWindowHandle(window);
			WinRT.Interop.InitializeWithWindow.Initialize(picker, hwnd);

			return picker.PickSaveFileAsync();
		}
	}
}
