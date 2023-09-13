using Microsoft.UI.Composition.SystemBackdrops;
using Microsoft.UI.Windowing;
using Microsoft.UI.Xaml.Media;
using Microsoft.UI.Xaml.Media.Animation;

namespace TestEditor
{
	/// <summary>
	/// An empty window that can be used on its own or navigated to within a Frame.
	/// </summary>
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

			rootFrame.Opacity = 1.0;
			rootFrame.Navigate(typeof(HomePage), null, new DrillInNavigationTransitionInfo());
		}
	}
}
