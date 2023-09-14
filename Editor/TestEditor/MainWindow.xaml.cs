using Microsoft.UI.Xaml.Media;
using Microsoft.UI.Xaml.Media.Animation;
using Microsoft.UI.Windowing;
using Microsoft.UI.Composition.SystemBackdrops;

namespace TestEditor
{
	public sealed partial class MainWindow : Window
	{
		private readonly DesktopAcrylicBackdrop acrylicBackdrop;

		public MainWindow()
		{
			InitializeComponent();

			if (DesktopAcrylicController.IsSupported())
			{
				acrylicBackdrop = new();
				SystemBackdrop = acrylicBackdrop;
			}

			if (AppWindowTitleBar.IsCustomizationSupported())
			{
				ExtendsContentIntoTitleBar = true;

				SetTitleBar(appTitleBar);
			}
			else
			{
				ExtendsContentIntoTitleBar = true;

				appTitleBar.Visibility = Visibility.Collapsed;
			}

			this.Track();

			rootFrame.Opacity = 1.0;
			rootFrame.Navigate(typeof(HomePage), null, new DrillInNavigationTransitionInfo());
		}
	}
}
