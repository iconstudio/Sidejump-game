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

	internal struct WindowView : IEquatable<WindowView>
	{
		internal class Style : IEquatable<Style>, IComparable<Style>
		{
			internal nint value;

			public Style(nint style = 0)
			{
				value = style;
			}

			[Pure]
			public override bool Equals(object other)
			{
				if (other is null)
					return false;

				return other.Equals(this);
			}
			[Pure]
			public bool Equals(Style other)
			{
				return value == other.value;
			}
			[Pure]
			public int CompareTo(Style other)
			{
				return value.CompareTo(other.value);
			}
			[Pure]
			public override int GetHashCode()
			{
				return value.GetHashCode();
			}

			public static explicit operator nint(Style style)
			{
				return style.value;
			}
		}
		internal class Option : IEquatable<Option>, IComparable<Option>
		{
			internal nint value;

			public Option(WINDOW_EX_STYLE options)
				: this((nint) options)
			{ }
			public Option(nint options = 0)
			{
				value = options;
			}

			[Pure]
			public override bool Equals(object other)
			{
				if (other is null)
					return false;

				return other.Equals(this);
			}
			[Pure]
			public bool Equals(Option other)
			{
				return value == other.value;
			}
			[Pure]
			public int CompareTo(Option other)
			{
				return value.CompareTo(other.value);
			}
			[Pure]
			public override int GetHashCode()
			{
				return value.GetHashCode();
			}

			public static explicit operator nint(Option option)
			{
				return option.value;
			}
		}

		private WindowSubRoutine mySubRoutine;
		private Style myStyles;
		private Option myOptions;

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
		public Style Styles
		{
			readonly get => myStyles;
			set
			{
				myStyles = value;
				PInvoke.SetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_STYLE, (nint) value);
			}
		}
		public Option Options
		{
			readonly get => myOptions;
			set
			{
				myOptions = value;
				PInvoke.SetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_EXSTYLE, (nint) value);
			}
		}

		public WindowView(Window target)
		{
			Implement = target;

			IntPtr hwnd = WinRT.Interop.WindowNative.GetWindowHandle(Implement);
			NativeHandle = new(hwnd);
			mySubRoutine = null;

			myStyles = new(PInvoke.GetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_STYLE));
			myOptions = new(PInvoke.GetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_EXSTYLE));
		}

		public readonly void Activate() => Implement?.Activate();
		public readonly void Close() => Implement?.Activate();
		public readonly void SetTitleBar(UIElement titleBar) => Implement?.SetTitleBar(titleBar);
		public readonly void AddStyle(nint style)
		{
			myStyles.value |= style;
			PInvoke.SetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_STYLE, myStyles.value);
		}
		public readonly void RemoveStyle(nint style)
		{
			myStyles.value &= ~style;
			PInvoke.SetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_STYLE, myStyles.value);
		}
		public readonly void AddOption(WINDOW_EX_STYLE option)
		{
			myOptions.value |= (nint) option;
			PInvoke.SetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_EXSTYLE, myOptions.value);
		}
		public readonly void RemoveOption(WINDOW_EX_STYLE option)
		{
			myOptions.value &= ~(nint) option;
			PInvoke.SetWindowLongPtr(NativeHandle, WINDOW_LONG_PTR_INDEX.GWL_EXSTYLE, myOptions.value);
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
