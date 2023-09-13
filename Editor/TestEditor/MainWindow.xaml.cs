using Microsoft.UI.Xaml.Media;
using Microsoft.UI.Xaml.Media.Animation;
using Microsoft.UI.Windowing;
using Microsoft.UI.Composition.SystemBackdrops;

namespace TestEditor
{
	public sealed partial class MainWindow : Window
	{
		public MainWindow()
		{
			InitializeComponent();

			if (DesktopAcrylicController.IsSupported())
			{
				DesktopAcrylicBackdrop DesktopAcrylicBackdrop = new();
				SystemBackdrop = DesktopAcrylicBackdrop;
			}

			if (AppWindowTitleBar.IsCustomizationSupported())
			{
				ExtendsContentIntoTitleBar = true;
				SetTitleBar(appTitleBar);
			}
			else
			{
				appTitleBar.Visibility = Visibility.Collapsed;
			}

			this.Track();

			rootFrame.Opacity = 1.0;
			rootFrame.Navigate(typeof(HomePage), null, new DrillInNavigationTransitionInfo());
		}
	}
}
