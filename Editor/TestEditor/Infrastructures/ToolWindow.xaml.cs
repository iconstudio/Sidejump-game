using Microsoft.UI.Composition.SystemBackdrops;
using Microsoft.UI.Windowing;
using Microsoft.UI.Xaml.Media;

using Windows.Win32.UI.WindowsAndMessaging;

using TestEditor.WinUI;

namespace TestEditor
{
	public sealed partial class ToolWindow : Window
	{
		private readonly DesktopAcrylicBackdrop acrylicBackdrop;
		internal OverlappedPresenter myPresenter;
		internal bool ForceActiveBar = true;
		internal WindowProjection myProject;

		public ToolWindow()
		{
			InitializeComponent();

			if (DesktopAcrylicController.IsSupported())
			{
				acrylicBackdrop = new();
				SystemBackdrop = acrylicBackdrop;
			}

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
			AppWindow.IsShownInSwitchers = false;

			myProject = WindowProjection.CreateFrom(this);
			myProject.Options |= WINDOW_EX_STYLE.WS_EX_TOOLWINDOW;
		}

		public void SetAlwaysOnTop(bool flag)
		{
			myPresenter.IsAlwaysOnTop = flag;
		}
	}
}
