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
		private const WindowStyle defaultStyle = WindowStyle.WS_CAPTION | WindowStyle.WS_SYSMENU | WindowStyle.WS_CHILD;
		private const WindowOption defaultOption = WindowOption.WS_EX_NOACTIVATE | WindowOption.WS_EX_PALETTEWINDOW | WindowOption.WS_EX_COMPOSITED | WindowOption.WS_EX_LAYERED | WindowOption.WS_EX_TRANSPARENT;

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

			myView = new(this)
			{
				Styles = defaultStyle,
				Options = defaultOption
			};
		}

		public void ShowOnTopMost()
		{
		}
		public void HideFromTopMost()
		{
			//AppWindow.MoveInZOrderAtBottom();
		}
	}
}
