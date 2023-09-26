using System.Diagnostics;
using System.Runtime.InteropServices;

using Windows.Devices.Display;
using Windows.Devices.Enumeration;
using Windows.Graphics;
using Windows.Win32;
using Windows.Win32.Foundation;
using Windows.Win32.UI.WindowsAndMessaging;

using TestEditor.Utility;
using TestEditor.WinUI;
using WinUIEx;

namespace TestEditor
{
	using WindowSubRoutine = Windows.Win32.UI.Shell.SUBCLASSPROC;

	public partial class App : Application, ISingleton<App>
	{
		public const int minWidth = 600;
		public const int minHeight = 400;
		internal static readonly SizeInt32 minSize = new(minWidth, minHeight);
		internal static readonly SizeInt32 displaySize;

		internal Window myWindow;
		internal WindowProjection myProject;

		internal event WindowSubRoutine SubRoutines
		{
			add => myProject.SubRoutines += value;
			remove => myProject.SubRoutines -= value;
		}

		static App()
		{
			var display_task = AcquireDisplaySize();
			display_task.Wait();

			displaySize = display_task.Result;
		}
		public App()
		{
			InitializeComponent();

			ISingleton<App>.SetInstance(this);
		}

		protected override void OnLaunched(LaunchActivatedEventArgs args)
		{
			try
			{
				myWindow = WindowHelper.CreateWindow<MainWindow>();
				myWindow.CenterOnScreen();

				myProject = WindowProjection.CreateFrom(myWindow);
			}
			catch (Exception e)
			{
				Debug.Print(e.ToString());
				return;
			}

			myProject.SubRoutines += MainHook;

			myProject.Activate();
		}

		public static App GetInstance() => ISingleton<App>.SingleInstance;

		private static LRESULT MainHook(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam, nuint id, nuint refdata)
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
		public static async Task<SizeInt32> AcquireDisplaySize()
		{
			var displays = await DeviceInformation.FindAllAsync(DisplayMonitor.GetDeviceSelector());

			if (0 < displays.Count)
			{
				throw new InvalidOperationException();
			}

			var monitor = await DisplayMonitor.FromInterfaceIdAsync(displays[0].Id);

			var result = new SizeInt32();
			if (monitor is null)
			{
				// these are app's size
				result.Width = minWidth;
				result.Height = minHeight;
			}
			else
			{
				result.Width = monitor.NativeResolutionInRawPixels.Width;
				result.Height = monitor.NativeResolutionInRawPixels.Height;
			}

			return result;
		}
	}
}
