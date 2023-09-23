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

	internal class WindowProjection : IWindowView
	{
		private Dictionary<nuint, WindowSubRoutine> mySubRoutines = new();
		private nuint lastSubRoutineId = 0;
		private bool isVisible;
		private WindowStyle myStyles;
		private WindowOption myOptions;
		private bool isDisposed;

		public Window Implement { get; }
		public HWND NativeHandle { get; }
		public AppWindow AppWindow => Implement.AppWindow;
		public CoreWindow CoreWindow => Implement.CoreWindow;
		public UIElement Content
		{
			get => Implement.Content;
			set => Implement.Content = value;
		}
		public DispatcherQueue DispatcherQueue => Implement.DispatcherQueue;
		public bool Visible
		{
			get => isVisible;
			set
			{
				if (value)
				{
					if (!isVisible)
					{
						Implement.AppWindow.Show();
						isVisible = true;
					}
				}
				else
				{
					if (isVisible)
					{
						Implement.AppWindow.Hide();
						isVisible = false;
					}
				}
			}
		}
		public Rect Bounds => Implement.Bounds;
		public uint Dpi => ((IWindowView) this).Dpi;
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
		public SystemBackdrop SystemBackdrop
		{
			get => Implement.SystemBackdrop;
			set => Implement.SystemBackdrop = value;
		}
		public WindowStyle Styles
		{
			get => myStyles;
			set
			{
				myStyles = value;

				PInvoke.SetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_STYLE, (nint) myStyles);
			}
		}
		public WindowOption Options
		{
			get => myOptions;
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

			isVisible = Implement.Visible;
			myStyles = (WindowStyle) PInvoke.GetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_STYLE);
			myOptions = (WindowOption) PInvoke.GetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_EXSTYLE);
		}

		public void Activate() => Implement.Activate();
		public void Close() => Implement.Activate();
		public void SetTitleBar(UIElement titleBar) => Implement.SetTitleBar(titleBar);
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
		public override bool Equals(object obj)
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
		public bool Equals(IWindowView other)
		{
			return Implement == other.Implement;
		}
		[Pure]
		public override int GetHashCode()
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
