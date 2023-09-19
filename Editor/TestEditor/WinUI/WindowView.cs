using System.Diagnostics.Contracts;

using Microsoft.UI.Dispatching;
using Microsoft.UI.Windowing;
using Microsoft.UI.Xaml.Media;

using Windows.Foundation;
using Windows.UI.Core;
using Windows.Win32.Foundation;

using WindowActivatedEventArgs = Microsoft.UI.Xaml.WindowActivatedEventArgs;
using WindowSizeChangedEventArgs = Microsoft.UI.Xaml.WindowSizeChangedEventArgs;

namespace TestEditor.WinUI
{
	internal readonly struct WindowView : IEquatable<WindowView>
	{
		public Window Implement { get; init; }
		public HWND NativeHandle { get; init; }
		public AppWindow AppWindow => Implement.AppWindow;
		public CoreWindow CoreWindow => Implement.CoreWindow;
		public static Window Current => Window.Current;
		public UIElement Content { get => Implement.Content; set => Implement.Content = value; }
		public DispatcherQueue DispatcherQueue => Implement.DispatcherQueue;
		public string Title { get => Implement.Title; set => Implement.Title = value; }
		public Rect Bounds => Implement.Bounds;
		public bool ExtendsContentIntoTitleBar { get => Implement.ExtendsContentIntoTitleBar; set => Implement.ExtendsContentIntoTitleBar = value; }
		public SystemBackdrop SystemBackdrop { get => Implement.SystemBackdrop; set => Implement.SystemBackdrop = value; }
		public bool Visible => Implement.Visible;

		public event TypedEventHandler<object, WindowActivatedEventArgs> Activated
		{
			add => Implement.Activated += value;
			remove => Implement.Activated -= value;
		}
		public event TypedEventHandler<object, WindowEventArgs> Closed
		{
			add => Implement.Closed += value;
			remove => Implement.Closed -= value;
		}
		public event TypedEventHandler<object, WindowSizeChangedEventArgs> SizeChanged
		{
			add => Implement.SizeChanged += value;
			remove => Implement.SizeChanged -= value;
		}
		public event TypedEventHandler<object, WindowVisibilityChangedEventArgs> VisibilityChanged
		{
			add => Implement.VisibilityChanged += value;
			remove => Implement.VisibilityChanged -= value;
		}

		public WindowView(Window target)
		{
			Implement = target;

			IntPtr hwnd = WinRT.Interop.WindowNative.GetWindowHandle(Implement);
			NativeHandle = new(hwnd);
		}

		public void Activate() => Implement?.Activate();
		public void Close() => Implement?.Activate();
		public void SetTitleBar(UIElement titleBar) => Implement?.SetTitleBar(titleBar);

		public static I As<I>()
		{
			return Window.As<I>();
		}

		[Pure]
		public override bool Equals(object obj)
		{
			if (obj is null)
			{
				return false;
			}

			return obj.Equals(this);
		}
		[Pure]
		public bool Equals(WindowView other)
		{
			return Implement == other.Implement;
		}
		[Pure]
		public override int GetHashCode()
		{
			return Implement.GetHashCode();
		}

		[Pure]
		public static bool operator ==(WindowView x, WindowView y)
		{
			return x.Implement == y.Implement;
		}
		[Pure]
		public static bool operator !=(WindowView x, WindowView y)
		{
			return !(x == y);
		}
		[Pure]
		public static bool operator ==(WindowView x, Window y)
		{
			return x.Implement == y;
		}
		[Pure]
		public static bool operator !=(WindowView x, Window y)
		{
			return !(x == y);
		}
	}
}
