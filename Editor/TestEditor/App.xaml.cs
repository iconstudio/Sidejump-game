﻿using System.Diagnostics;
using System.Runtime.InteropServices;

using Windows.Win32;
using Windows.Win32.Foundation;
using Windows.Win32.UI.WindowsAndMessaging;

using TestEditor.Utility;
using TestEditor.WinUI;
using WinUIEx;

namespace TestEditor
{
	public partial class App : Application, ISingleton<App>
	{
		public const int minWidth = 600;
		public const int minHeight = 400;

		internal Window myWindow;
		internal WindowProjection myProject;

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

				myProject = new(myWindow);
			}
			catch (Exception e)
			{
				Debug.Print(e.ToString());
				return;
			}

			myProject.SubRoutines += MainHook;

			myProject.Activate();
		}
		private LRESULT MainHook(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam, nuint id, nuint refdata)
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

		public static App GetInstance() => ISingleton<App>.SingleInstance;
	}
}
