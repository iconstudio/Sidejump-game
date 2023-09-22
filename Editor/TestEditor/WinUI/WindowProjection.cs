using System.Diagnostics.Contracts;
using System.Runtime.InteropServices;

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

	internal struct WindowProjection : IWindowView
	{
		private Dictionary<nuint, WindowSubRoutine> mySubRoutines = new();
		private nuint lastSubRoutineId = 0;
		private WindowStyle myStyles = 0;
		private WindowOption myOptions = 0;
		private bool isDisposed = false;

		public Window Implement { get; }
		public HWND NativeHandle { get; }
		public readonly AppWindow AppWindow => Implement.AppWindow;
		public readonly CoreWindow CoreWindow => Implement.CoreWindow;
		public readonly UIElement Content
		{
			get => Implement.Content;
			set => Implement.Content = value;
		}
		public readonly DispatcherQueue DispatcherQueue => Implement.DispatcherQueue;
		public readonly bool Visible => ((IWindowView) this).Visible;
		public readonly Rect Bounds => Implement.Bounds;
		public readonly uint Dpi => ((IWindowView) this).Dpi;
		public readonly string Title
		{
			get => Implement.Title;
			set => Implement.Title = value;
		}
		public readonly bool ExtendsContentIntoTitleBar
		{
			get => Implement.ExtendsContentIntoTitleBar;
			set => Implement.ExtendsContentIntoTitleBar = value;
		}
		public readonly SystemBackdrop SystemBackdrop
		{
			get => Implement.SystemBackdrop;
			set => Implement.SystemBackdrop = value;
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

						if (PInvoke.SetWindowSubclass(NativeHandle, routine, lastSubRoutineId, 0))
						{
							mySubRoutines.Add(lastSubRoutineId++, routine);
						}
					}
				}
			}
			remove
			{
				lock (mySubRoutines)
				{
					foreach (var pair in mySubRoutines)
					{
						if (pair.Value == value)
						{
							PInvoke.RemoveWindowSubclass(NativeHandle, pair.Value, pair.Key);
							mySubRoutines.Remove(pair.Key);

							break;
						}
					}
				}
			}
		}

		public WindowProjection()
		{
			Implement = null;
			NativeHandle = HWND.Null;
		}
		public WindowProjection(Window target)
		{
			Implement = target;

			IntPtr hwnd = WinRT.Interop.WindowNative.GetWindowHandle(Implement);
			NativeHandle = new(hwnd);

			myStyles = (WindowStyle) PInvoke.GetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_STYLE);
			myOptions = (WindowOption) PInvoke.GetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_EXSTYLE);
		}

		public readonly void Activate() => Implement.Activate();
		public readonly void Close() => Implement.Activate();
		public readonly void SetTitleBar(UIElement titleBar) => Implement.SetTitleBar(titleBar);
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
		private void Dispose(bool disposing)
		{
			if (isDisposed)
			{
				return;
			}

			if (disposing)
			{
				Marshal.DestroyStructure(NativeHandle, typeof(HWND));
			}

			isDisposed = true;
		}
		public void Dispose()
		{
			Dispose(true);
			GC.SuppressFinalize(this);
		}

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

		public static implicit operator Window(in WindowProjection view)
		{
			return view.Implement;
		}
		public static implicit operator HWND(in WindowProjection view)
		{
			return view.NativeHandle;
		}
		[Pure]
		public static bool operator ==(in WindowProjection x, in WindowProjection y)
		{
			return x.Implement == y.Implement;
		}
		[Pure]
		public static bool operator !=(in WindowProjection x, in WindowProjection y)
		{
			return !(x == y);
		}
		[Pure]
		public static bool operator ==(in WindowProjection x, in Window y)
		{
			return x.Implement == y;
		}
		[Pure]
		public static bool operator !=(in WindowProjection x, in Window y)
		{
			return !(x == y);
		}
	}
}
