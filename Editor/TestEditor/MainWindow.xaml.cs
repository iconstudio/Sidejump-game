using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Threading.Tasks;

using Microsoft.UI.Xaml.Data;
using Microsoft.UI.Xaml.Input;
using Microsoft.UI.Xaml.Media;
using Microsoft.UI.Xaml.Media.Animation;
using Microsoft.UI.Xaml.Navigation;
using Microsoft.UI.Composition.SystemBackdrops;
using Microsoft.UI.Composition.Scenes;

using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.Win32;
using Windows.Win32.UI.WindowsAndMessaging;
using Windows.Win32.Foundation;
using Windows.Graphics;
using Windows.Win32.UI.Shell;

namespace TestEditor
{
	/// <summary>
	/// An empty window that can be used on its own or navigated to within a Frame.
	/// </summary>
	public sealed partial class MainWindow : Window
	{
		int minWidth = 400;
		int minHeight = 400;

		SUBCLASSPROC procHooker;

		public MainWindow()
		{
			InitializeComponent();

			if (DesktopAcrylicController.IsSupported())
			{
				DesktopAcrylicBackdrop DesktopAcrylicBackdrop = new();
				SystemBackdrop = DesktopAcrylicBackdrop;
			}

			ExtendsContentIntoTitleBar = true;
			SetTitleBar(appTitleBar);

			SubClassing();
			/*
			minResolution = new(minWidth, minHeight);
			AppWindow.Changed += (AppWindow, AppWindowChangedEventArg) =>
			{
				if (AppWindowChangedEventArg.DidSizeChange)
				{
					var wsize = AppWindow.Size;
					myResolution.Width = Math.Max(wsize.Width, minResolution.Width);
					myResolution.Height = Math.Max(wsize.Height, minResolution.Height);

					AppWindow.Resize(myResolution);
				}
			};
			*/

			rootFrame.Opacity = 1.0;
			rootFrame.Navigate(typeof(HomePage), null, new DrillInNavigationTransitionInfo());
		}

		void SubClassing()
		{
			var hwnd = WinRT.Interop.WindowNative.GetWindowHandle(this);
			procHooker = new(SizeHooker);

			PInvoke.SetWindowSubclass((HWND) hwnd, procHooker, 0, 0);
		}
		LRESULT SizeHooker(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam, nuint id, nuint refdata)
		{
			switch (uMsg)
			{
				case PInvoke.WM_GETMINMAXINFO:
				{
					var dpi = PInvoke.GetDpiForWindow(hWnd);
					float scalingFactor = (float) dpi / 96;

					MINMAXINFO minMaxInfo = Marshal.PtrToStructure<MINMAXINFO>(lParam);
					minMaxInfo.ptMinTrackSize.X = (int) (minWidth * scalingFactor);
					minMaxInfo.ptMinTrackSize.Y = (int) (minHeight * scalingFactor);

					Marshal.StructureToPtr(minMaxInfo, lParam, true);
				}

				return (LRESULT) 1;
			}

			return PInvoke.DefSubclassProc(hWnd, uMsg, wParam, lParam);
		}
	}
}
