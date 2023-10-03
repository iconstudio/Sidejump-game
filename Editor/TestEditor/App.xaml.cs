﻿using System.Diagnostics;
using System.Runtime.InteropServices;

using Windows.ApplicationModel;
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

	public partial class App : Application, ISingleton<App>, IDisposable
	{
		public const int minWidth = 600;
		public const int minHeight = 400;

		internal Window myWindow;
		internal WindowProjection myProject;

		public static string Version { get; }
		public static SizeInt32 MinimumResolution { get; }
		public static SizeInt32 DisplaySize { get; private set; }

		internal event WindowSubRoutine SubRoutines
		{
			add => myProject.SubRoutines += value;
			remove => myProject.SubRoutines -= value;
		}

		static App()
		{
			Version = string.Format(null, "v{0}.{1}.{2}.{3}",
				Package.Current.Id.Version.Major,
				Package.Current.Id.Version.Minor,
				Package.Current.Id.Version.Build,
				Package.Current.Id.Version.Revision);

			MinimumResolution = new(minWidth, minHeight);
		}
		public App()
		{
			InitializeComponent();

			ISingleton<App>.SetInstance(this);
		}

		public void Dispose()
		{
			myProject.Dispose();
			GC.SuppressFinalize(this);
		}

		protected override async void OnLaunched(LaunchActivatedEventArgs args)
		{
			try
			{
				DisplaySize = await AcquireDisplaySize();
			}
			catch (ObjectDisposedException e)
			{
				Debug.Fail("ObjectDisposedException" + e.ToString());
				return;
			}
			catch (InvalidOperationException e)
			{
				Debug.Fail("InvalidOperationException" + e.ToString());
				return;
			}

			try
			{
				myWindow = WindowHelper.CreateWindow<MainWindow>();
				myProject = WindowProjection.CreateFrom(myWindow);

				myWindow.CenterOnScreen();
			}
			catch (Exception e)
			{
				Debug.Fail(e.ToString());
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

			if (0 == displays.Count)
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
