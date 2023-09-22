using System.Diagnostics.Contracts;

using Microsoft.UI.Dispatching;
using Microsoft.UI.Windowing;
using Microsoft.UI.Xaml.Media;

using Windows.Foundation;
using Windows.UI.Core;
using Windows.Win32;
using Windows.Win32.Foundation;
using Windows.Win32.UI.WindowsAndMessaging;

namespace TestEditor.WinUI
{
	using WindowStyle = WINDOW_STYLE;
	using WindowOption = WINDOW_EX_STYLE;

	internal interface IWindowView : IEquatable<IWindowView>, IDisposable
	{
		public abstract Window Implement { get; }
		public abstract HWND NativeHandle { get; }
		public AppWindow AppWindow => Implement.AppWindow;
		public CoreWindow CoreWindow => Implement.CoreWindow;
		public UIElement Content => Implement.Content;
		public DispatcherQueue DispatcherQueue => Implement.DispatcherQueue;
		public bool Visible => Implement.Visible;
		public Rect Bounds => Implement.Bounds;
		public uint Dpi => PInvoke.GetDpiForWindow(NativeHandle);
		public string Title
		{
			get => Implement.Title;
			set => Implement.Title = value;
		}
		public bool ExtendsContentIntoTitleBar
		{
			get => Implement.ExtendsContentIntoTitleBar;
			set => Implement.ExtendsContentIntoTitleBar = value;
		}
		public SystemBackdrop SystemBackdrop { get => Implement.SystemBackdrop; set => Implement.SystemBackdrop = value; }
		public WindowStyle Styles => (WindowStyle) PInvoke.GetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_STYLE);
		public WindowOption Options => (WindowOption) PInvoke.GetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_EXSTYLE);
	}
}
