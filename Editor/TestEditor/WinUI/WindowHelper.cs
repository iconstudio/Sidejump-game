using Microsoft.UI;
using Microsoft.UI.Windowing;

using WinRT.Interop;

namespace TestEditor.WinUI
{
	internal static class WindowHelper
	{
		internal static List<Window> trackedWindows = new();

		internal static
			Window
			CreateWindow()
		{
			var window = new Window();
			window?.Track();
			return window;
		}
		internal static
			W
			CreateWindow<W>() where W : Window, new()
		{
			var window = new W();
			window?.Track();
			return window;
		}
		internal static
			W
			CreateWindow<W>(Func<W> generator)
				where W : Window, new()
		{
			var window = generator();
			window?.Track();
			return window;
		}
		internal static
			W
			CreateWindow<T0, W>(Func<T0, W> generator, T0 arg0)
				where W : Window, new()
		{
			var window = generator(arg0);
			window?.Track();
			return window;
		}
		internal static
			W
			CreateWindow<T0, T1, W>(Func<T0, T1, W> generator, T0 arg0, T1 arg1)
				where W : Window, new()
		{
			var window = generator(arg0, arg1);
			window?.Track();
			return window;
		}
		internal static
			W
			CreateWindow<T0, T1, T2, W>(Func<T0, T1, T2, W> generator, T0 arg0, T1 arg1, T2 arg2)
				where W : Window, new()
		{
			var window = generator(arg0, arg1, arg2);
			window?.Track();
			return window;
		}
		internal static
			W
			CreateWindow<T0, T1, T2, T3, W>(Func<T0, T1, T2, T3, W> generator, T0 arg0, T1 arg1, T2 arg2, T3 arg3)
				where W : Window, new()
		{
			var window = generator(arg0, arg1, arg2, arg3);
			window?.Track();
			return window;
		}
		internal static
			W
			CreateWindow<T0, T1, T2, T3, T4, W>(Func<T0, T1, T2, T3, T4, W> generator, T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
				where W : Window, new()
		{
			var window = generator(arg0, arg1, arg2, arg3, arg4);
			window?.Track();
			return window;
		}
		internal static
			W
			CreateWindow<T0, T1, T2, T3, T4, T5, W>(Func<T0, T1, T2, T3, T4, T5, W> generator, T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
				where W : Window, new()
		{
			var window = generator(arg0, arg1, arg2, arg3, arg4, arg5);
			window?.Track();
			return window;
		}

		internal static AppWindow GetAppWindow(this Window window)
		{
			IntPtr hwnd = WindowNative.GetWindowHandle(window);
			WindowId id = Win32Interop.GetWindowIdFromWindow(hwnd);

			return AppWindow.GetFromWindowId(id);
		}
		internal static void Track(this Window window)
		{
			trackedWindows.Add(window);
		}
		internal static void TrackWindow(Window window)
		{
			trackedWindows.Add(window);
		}
	}
}
