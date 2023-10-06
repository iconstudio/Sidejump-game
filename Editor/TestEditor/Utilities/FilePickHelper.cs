using Windows.Foundation;
using Windows.Storage;
using Windows.Storage.Pickers;
using Windows.Win32.Foundation;

using TestEditor.Editor;

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
			OpenSavePicker(Window window, params KeyValuePair<string, IList<string>>[] extentions)
		{
			var hwnd = WinRT.Interop.WindowNative.GetWindowHandle(window);

			return OpenSavePicker((HWND) hwnd, extentions);
		}
		internal static
			IAsyncOperation<StorageFile>
			OpenSavePicker(HWND hwnd, params KeyValuePair<string, IList<string>>[] extentions)
		{
			FileSavePicker picker = new();
			picker.FileTypeChoices.Clear();
			foreach (var ext_pair in extentions)
			{
				picker.FileTypeChoices.Add(ext_pair);
			}

			WinRT.Interop.InitializeWithWindow.Initialize(picker, hwnd);

			return picker.PickSaveFileAsync();
		}
		internal static
			IAsyncOperation<StorageFile>
			OpenSavePicker(Window window, IEnumerable<KeyValuePair<string, IList<string>>> extentions)
		{
			var hwnd = WinRT.Interop.WindowNative.GetWindowHandle(window);

			return OpenSavePicker((HWND) hwnd, extentions);
		}
		internal static
			IAsyncOperation<StorageFile>
			OpenSavePicker(HWND hwnd, IEnumerable<KeyValuePair<string, IList<string>>> extentions)
		{
			FileSavePicker picker = new();
			picker.FileTypeChoices.Clear();
			foreach (var ext_pair in extentions)
			{
				picker.FileTypeChoices.Add(ext_pair);
			}
			//picker.FileTypeChoices.Add("Map File", new List<string>() { EditorFileHelper.MapExtension });
			//picker.FileTypeChoices.Add("Archieved Map File", new List<string>() { ".zip" });

			WinRT.Interop.InitializeWithWindow.Initialize(picker, hwnd);

			return picker.PickSaveFileAsync();
		}
	}
}
