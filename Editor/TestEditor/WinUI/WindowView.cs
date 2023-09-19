using System.Diagnostics.Contracts;

using Microsoft.UI.Dispatching;
using Microsoft.UI.Windowing;
using Microsoft.UI.Xaml.Media;

using Windows.Foundation;
using Windows.UI.Core;
using Windows.Win32;
using Windows.Win32.Foundation;
using Windows.Win32.UI;
using Windows.Win32.UI.Shell;

namespace TestEditor.WinUI
{
	using WindowActivatedEventArgs = Microsoft.UI.Xaml.WindowActivatedEventArgs;
	using WindowSizeChangedEventArgs = Microsoft.UI.Xaml.WindowSizeChangedEventArgs;
	using WindowSubRoutine = Windows.Win32.UI.Shell.SUBCLASSPROC;

	internal struct WindowView : IEquatable<WindowView>
	{
		private WindowSubRoutine mySubRoutine;

		public readonly Window Implement { get; init; }
		public readonly HWND NativeHandle { get; init; }
		public readonly AppWindow AppWindow => Implement.AppWindow;
		public readonly CoreWindow CoreWindow => Implement.CoreWindow;
		public static Window Current => Window.Current;
		public readonly UIElement Content { get => Implement.Content; set => Implement.Content = value; }
		public readonly DispatcherQueue DispatcherQueue => Implement.DispatcherQueue;
		public readonly string Title { get => Implement.Title; set => Implement.Title = value; }
		public readonly Rect Bounds => Implement.Bounds;
		public readonly bool ExtendsContentIntoTitleBar { get => Implement.ExtendsContentIntoTitleBar; set => Implement.ExtendsContentIntoTitleBar = value; }
		public readonly SystemBackdrop SystemBackdrop { get => Implement.SystemBackdrop; set => Implement.SystemBackdrop = value; }
		public readonly bool Visible => Implement.Visible;

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
		public WindowSubRoutine SubRoutine
		{
			readonly get => mySubRoutine;
			set
			{
				mySubRoutine = new(value);
                PInvoke.SetWindowSubclass(NativeHandle, mySubRoutine, 0, 0);
			}
		}

		public WindowView(Window target)
		{
			Implement = target;

			IntPtr hwnd = WinRT.Interop.WindowNative.GetWindowHandle(Implement);
			NativeHandle = new(hwnd);
			mySubRoutine = null;
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

		public static implicit operator Window(WindowView view)
		{
			return view.Implement;
		}
		public static implicit operator HWND(WindowView view)
		{
			return view.NativeHandle;
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
