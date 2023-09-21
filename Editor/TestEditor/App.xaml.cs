using System.Diagnostics;
using System.Runtime.InteropServices;

using Windows.Win32;
using Windows.Win32.Foundation;
using Windows.Win32.UI.Shell;
using Windows.Win32.UI.WindowsAndMessaging;

using TestEditor.WinUI;

namespace TestEditor
{
	public partial class App : Application
	{
		private Window myWindow;
		private WindowView myView;

		private const int minWidth = 600;
		private const int minHeight = 400;

		public App()
		{
			InitializeComponent();
		}

		protected override void OnLaunched(LaunchActivatedEventArgs args)
		{
			try
			{
				myWindow = WindowHelper.CreateWindow<MainWindow>();
				myView = new(myWindow);
			}
			catch (Exception e)
			{
				Debug.Print(e.ToString());
				return;
			}

			myView.SubRoutine += SizeHooker;

			myView.Activate();
		}
		private LRESULT SizeHooker(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam, nuint id, nuint refdata)
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
