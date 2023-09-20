using System.Diagnostics.Contracts;

using Microsoft.UI.Dispatching;
using Microsoft.UI.Windowing;
using Microsoft.UI.Xaml.Media;

using Windows.Foundation;
using Windows.UI.Core;
using Windows.Win32;
using Windows.Win32.Foundation;
using Windows.Win32.UI.Shell;
using Windows.Win32.UI.WindowsAndMessaging;

namespace TestEditor.WinUI
{
	using WindowActivatedEventArgs = Microsoft.UI.Xaml.WindowActivatedEventArgs;
	using WindowSizeChangedEventArgs = Microsoft.UI.Xaml.WindowSizeChangedEventArgs;
	using WindowSubRoutine = Windows.Win32.UI.Shell.SUBCLASSPROC;
	using WindowStyle = WINDOW_STYLE;
	using WindowOption = WINDOW_EX_STYLE;

	internal struct WindowView : IEquatable<WindowView>
	{
		private List<WindowSubRoutine> mySubRoutines;
		private WindowStyle myStyles;
		private WindowOption myOptions;

		public readonly Window Implement { get; init; }
		public readonly HWND NativeHandle { get; init; }
		public readonly AppWindow AppWindow => Implement.AppWindow;
		public readonly CoreWindow CoreWindow => Implement.CoreWindow;
		public static Window Current => Window.Current;
		public readonly UIElement Content { get => Implement.Content; set => Implement.Content = value; }
		public readonly DispatcherQueue DispatcherQueue => Implement.DispatcherQueue;
		public readonly string Title { get => Implement.Title; set => Implement.Title = value; }
		public readonly Rect Bounds => Implement.Bounds;
		public readonly uint Dpi => PInvoke.GetDpiForWindow(NativeHandle);
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
		public event WindowSubRoutine SubRoutine
		{
			add
			{
				if (value is not null)
				{
					lock (mySubRoutines)
					{
						WindowSubRoutine routine = new(value);

						PInvoke.SetWindowSubclass(NativeHandle, routine, (nuint) mySubRoutines.Count, 0);
						mySubRoutines.Add(routine);
					}
				}
			}
			remove
			{
				lock (mySubRoutines)
				{
					var id = mySubRoutines.FindIndex(0, mySubRoutines.Count
					, (rhs) => { return rhs == value; });
					if (-1 != id)
					{
						PInvoke.RemoveWindowSubclass(NativeHandle, mySubRoutines[id], (nuint) id);

						mySubRoutines.RemoveAt(id);
					}
				}
			}
		}
		public WindowStyle Styles
		{
			readonly get => myStyles;
			set
			{
				myStyles = value;

				PInvoke.SetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_STYLE, (nint) myStyles);
			}
		}
		public WindowOption Options
		{
			readonly get => myOptions;
			set
			{
				myOptions = value;

				PInvoke.SetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_EXSTYLE, (nint) myOptions);
			}
		}

		public WindowView(Window target)
		{
			Implement = target;

			IntPtr hwnd = WinRT.Interop.WindowNative.GetWindowHandle(Implement);
			NativeHandle = new(hwnd);
			mySubRoutines = new();
			mySubRoutines.Capacity = 0;

			myStyles = (WindowStyle) PInvoke.GetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_STYLE);
			myOptions = (WindowOption) PInvoke.GetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_EXSTYLE);
		}

		public readonly void Activate() => Implement?.Activate();
		public readonly void Close() => Implement?.Activate();
		public readonly void SetTitleBar(UIElement titleBar) => Implement?.SetTitleBar(titleBar);
		public void AttachStyle(WindowStyle style)
		{
			Styles |= style;
		}
		public void DetachStyle(WindowStyle style)
		{
			Styles &= ~style;
		}
		public void SetWindowOption(WindowOption option)
		{
			Options |= option;
		}
		public void UnsetWindowOption(WindowOption option)
		{
			Options &= ~option;
		}

		public static I As<I>()
		{
			return Window.As<I>();
		}

		[Pure]
		public override readonly bool Equals(object obj)
		{
			if (obj is null)
			{
				return false;
			}

			return obj.Equals(this);
		}
		[Pure]
		public readonly bool Equals(WindowView other)
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
