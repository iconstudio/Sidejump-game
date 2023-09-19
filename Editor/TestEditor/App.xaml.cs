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
		private SUBCLASSPROC msgHooker;

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
				myWindow = new MainWindow();
				myView = new(myWindow);
			}
			catch (Exception e)
			{
				Debug.Print(e.ToString());
				return;
			}

			msgHooker = new(SizeHooker);

			PInvoke.SetWindowSubclass(myView, msgHooker, 0, 0);

			var xstyle = PInvoke.GetWindowLongPtr(myView, WINDOW_LONG_PTR_INDEX.GWL_EXSTYLE);
			xstyle |= (nint) WINDOW_EX_STYLE.WS_EX_TOOLWINDOW;

			PInvoke.SetWindowLongPtr(myView, WINDOW_LONG_PTR_INDEX.GWL_EXSTYLE, xstyle);

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
