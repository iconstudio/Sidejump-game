using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Microsoft.UI;
using Microsoft.UI.Windowing;

using WinRT.Interop;

namespace TestEditor
{
	internal static class UIElementExtension
	{
		private static List<Window> trackedWindows = new();

		public static void Track(this Window window)
		{
			trackedWindows.Add(window);
		}

		public static void TrackWindow(Window window)
		{
			trackedWindows.Add(window);
		}

		public static Window GetWindow(this UIElement element)
		{
			if (element.XamlRoot != null)
			{
				foreach (Window window in trackedWindows)
				{
					if (element.XamlRoot == window.Content.XamlRoot)
					{
						return window;
					}
				}
			}

			return null;
		}
		public static AppWindow GetAppWindow(this Window window)
		{
			IntPtr hwnd = WindowNative.GetWindowHandle(window);
			WindowId id = Win32Interop.GetWindowIdFromWindow(hwnd);

			return AppWindow.GetFromWindowId(id);
		}
	}
}
