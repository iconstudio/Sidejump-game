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
	using WindowActivatedEventArgs = Microsoft.UI.Xaml.WindowActivatedEventArgs;
	using WindowSizeChangedEventArgs = Microsoft.UI.Xaml.WindowSizeChangedEventArgs;
	using WindowSubRoutine = Windows.Win32.UI.Shell.SUBCLASSPROC;
	using WindowStyle = WINDOW_STYLE;
	using WindowOption = WINDOW_EX_STYLE;

	internal readonly struct WindowView : IWindowView
	{
		public readonly Window Implement { get; }
		public readonly HWND NativeHandle { get; }
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

		public WindowView(Window target)
		{
			Implement = target;

			NativeHandle = new(WinRT.Interop.WindowNative.GetWindowHandle(target));
		}

		public void Dispose()
		{ }

		[Pure]
		public override readonly bool Equals(object obj)
		{
			if (obj is null)
			{
				return false;
			}

			if (obj is IWindowView view)
			{
				return view.Implement.Equals(Implement);
			}

			return obj.Equals(Implement);
		}
		[Pure]
		public readonly bool Equals(IWindowView other)
		{
			return Implement == other.Implement;
		}
		[Pure]
		public readonly override int GetHashCode()
		{
			return Implement.GetHashCode();
		}

		public static implicit operator Window(in WindowView view)
		{
			return view.Implement;
		}
		public static implicit operator HWND(in WindowView view)
		{
			return view.NativeHandle;
		}
		[Pure]
		public static bool operator ==(in WindowView x, in WindowView y)
		{
			return x.Implement == y.Implement;
		}
		[Pure]
		public static bool operator !=(in WindowView x, in WindowView y)
		{
			return !(x == y);
		}
		[Pure]
		public static bool operator ==(in WindowView x, in Window y)
		{
			return x.Implement == y;
		}
		[Pure]
		public static bool operator !=(in WindowView x, in Window y)
		{
			return !(x == y);
		}
	}
}
