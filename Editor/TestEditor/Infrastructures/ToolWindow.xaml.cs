using Microsoft.UI.Composition.SystemBackdrops;
using Microsoft.UI.Windowing;
using Microsoft.UI.Xaml.Media;

using Windows.Win32.UI.WindowsAndMessaging;

using TestEditor.WinUI;

namespace TestEditor
{
	using WindowOption = WINDOW_EX_STYLE;
	using WindowStyle = WINDOW_STYLE;

	public sealed partial class ToolWindow : Window, IDisposable
	{
		private class ToolPresenterCreationFailedException : NullReferenceException
		{
			public ToolPresenterCreationFailedException(string message) : base(message)
			{ }
		}

		private const WindowStyle defaultStyle = WindowStyle.WS_CAPTION | WindowStyle.WS_SYSMENU;
		private const WindowOption defaultOption = WindowOption.WS_EX_PALETTEWINDOW | WindowOption.WS_EX_COMPOSITED | WindowOption.WS_EX_NOACTIVATE;

		private readonly DesktopAcrylicBackdrop acrylicBackdrop;

		internal WindowProjection myProject;
		internal OverlappedPresenter myPresenter;
		internal bool ForceActiveBar = true;

		public ToolWindow()
		{
			InitializeComponent();

			if (DesktopAcrylicController.IsSupported())
			{
				acrylicBackdrop = new();
				SystemBackdrop = acrylicBackdrop;
			}

			myProject = new(this)
			{
				Styles = defaultStyle,
				Options = defaultOption
			};

			myPresenter = OverlappedPresenter.Create();
			if (myPresenter is null)
			{
				throw new ToolPresenterCreationFailedException(nameof(myPresenter));
			}

			myPresenter.SetBorderAndTitleBar(true, true);
			myPresenter.IsAlwaysOnTop = true;
			myPresenter.IsResizable = false;
			myPresenter.IsMaximizable = false;
			myPresenter.IsMinimizable = false;

			AppWindow.SetPresenter(myPresenter);
		}

		public void Dispose()
		{
			myProject.Dispose();
		}

		private void OnLoaded(object sender, RoutedEventArgs _)
		{
		}
		private void OnFocused(object sender, RoutedEventArgs e)
		{

		}
	}
}
