using Microsoft.UI.Composition.SystemBackdrops;
using Microsoft.UI.Windowing;
using Microsoft.UI.Xaml.Media;

using Windows.Win32.UI.WindowsAndMessaging;

using TestEditor.WinUI;

namespace TestEditor
{
	using WindowOption = WINDOW_EX_STYLE;
	using WindowStyle = WINDOW_STYLE;

	public sealed partial class ToolWindow : Window
	{
		private const WindowStyle defaultStyle = WindowStyle.WS_POPUPWINDOW;
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
	}
}
