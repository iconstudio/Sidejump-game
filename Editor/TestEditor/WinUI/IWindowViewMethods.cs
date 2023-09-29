using Windows.Win32;
using Windows.Win32.Foundation;
using Windows.Win32.UI.WindowsAndMessaging;

namespace TestEditor.WinUI
{
	internal static class IWindowViewMethods
	{
		public static uint GetDPI(HWND handle)
		{
			uint dpi;
			if (0 == (dpi = PInvoke.GetDpiForWindow(handle)))
			{
				dpi = 96;
			}

			return dpi;
		}
		public static WINDOW_STYLE GetStyle(HWND handle)
		{
			return (WINDOW_STYLE) PInvoke.GetWindowLongPtr(handle, WINDOW_LONG_PTR_INDEX.GWL_STYLE);
		}
		public static WINDOW_EX_STYLE GetExStyle(HWND handle)
		{
			return (WINDOW_EX_STYLE) PInvoke.GetWindowLongPtr(handle, WINDOW_LONG_PTR_INDEX.GWL_EXSTYLE);
		}
	}
}
