using System.Diagnostics.Contracts;

using Microsoft.UI.Dispatching;
using Microsoft.UI.Windowing;
using Microsoft.UI.Xaml.Media;

using Windows.Foundation;
using Windows.UI.Core;
using Windows.Win32.Foundation;
using Windows.Win32.UI.WindowsAndMessaging;

namespace TestEditor.WinUI
{
	using WindowStyle = WINDOW_STYLE;
	using WindowOption = WINDOW_EX_STYLE;

	internal readonly struct ChildWindow : IWindowView, IDisposable
	{
		public readonly Window Window { get; }
		public readonly WindowProjection Projection { get; }
		public readonly Window Implement => ((IWindowView) Projection).Implement;
		public readonly HWND NativeHandle => ((IWindowView) Projection).NativeHandle;
		public readonly AppWindow AppWindow => ((IWindowView) this).AppWindow;
		public readonly CoreWindow CoreWindow => ((IWindowView) this).CoreWindow;
		public readonly UIElement Content => ((IWindowView) this).Content;
		public readonly DispatcherQueue DispatcherQueue => ((IWindowView) this).DispatcherQueue;
		public readonly bool Visible => ((IWindowView) this).Visible;
		public readonly Rect Bounds => ((IWindowView) this).Bounds;
		public readonly uint Dpi => ((IWindowView) this).Dpi;
		public readonly string Title => ((IWindowView) this).Title;
		public readonly bool ExtendsContentIntoTitleBar => ((IWindowView) this).ExtendsContentIntoTitleBar;
		public readonly SystemBackdrop SystemBackdrop => ((IWindowView) this).SystemBackdrop;
		public readonly WindowStyle Styles => ((IWindowView) this).Styles;
		public readonly WindowOption Options => ((IWindowView) this).Options;

		public ChildWindow(Window window, WindowProjection projection)
		{
			Window = window;
			Projection = projection;
		}

		public void Dispose()
		{
			((IDisposable) Projection).Dispose();
		}

		[Pure]
		public bool Equals(IWindowView other)
		{
			return ((IEquatable<IWindowView>) Projection).Equals(other);
		}
	}
}
