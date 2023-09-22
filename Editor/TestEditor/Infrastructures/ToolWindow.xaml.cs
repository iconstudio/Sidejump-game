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
		private const WindowStyle defaultStyle = WindowStyle.WS_POPUP;
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

			var presenter = OverlappedPresenter.Create();
			presenter.SetBorderAndTitleBar(true, true);
			presenter.IsAlwaysOnTop = false;
			presenter.IsResizable = false;
			presenter.IsMaximizable = false;
			presenter.IsMinimizable = false;

			//AppWindow.SetPresenter(presenter);

			myView = new(this);
			myView.Styles |= defaultStyle;
			myView.Options |= defaultOption;
		}
	}
}
