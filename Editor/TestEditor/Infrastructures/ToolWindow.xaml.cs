using System.Runtime.InteropServices;

using Microsoft.UI.Composition.SystemBackdrops;
using Microsoft.UI.Xaml.Media;

using Windows.Win32;
using Windows.Win32.Foundation;
using Windows.Win32.UI.WindowsAndMessaging;

using TestEditor.WinUI;

namespace TestEditor
{
	using WindowOption = WINDOW_EX_STYLE;
	using WindowStyle = WINDOW_STYLE;

	public sealed partial class ToolWindow : Window
	{
		private const WindowStyle defaultStyle = WindowStyle.WS_CAPTION | WindowStyle.WS_SYSMENU;
		private const WindowOption defaultOption = WindowOption.WS_EX_PALETTEWINDOW | WindowOption.WS_EX_COMPOSITED;

		private readonly DesktopAcrylicBackdrop acrylicBackdrop;

		private WindowView myView;

		public ToolWindow()
		{
			InitializeComponent();

			if (DesktopAcrylicController.IsSupported())
			{
				acrylicBackdrop = new();
				SystemBackdrop = acrylicBackdrop;
			}

			myView = new(this);
			myView.Styles = defaultStyle;
			myView.Options = defaultOption;
		}

		public void ShowOnTopMost()
		{
		}
		public void HideFromTopMost()
		{
			//AppWindow.MoveInZOrderAtBottom();
		}

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
	}
}
