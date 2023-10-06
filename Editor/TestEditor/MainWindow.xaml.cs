using Microsoft.UI.Xaml.Media;
using Microsoft.UI.Xaml.Media.Animation;
using Microsoft.UI.Windowing;
using Microsoft.UI.Composition.SystemBackdrops;

using TestEditor.Utility;
using TestEditor.WinUI;

namespace TestEditor
{
	public sealed partial class MainWindow : Window, ISingleton<MainWindow>
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
				appTitleBar.Visibility = Visibility.Collapsed;
			}

			ISingleton<MainWindow>.SetInstance(this);

			rootFrame.Opacity = 1.0;

			NavigationHelper.Goto(typeof(HomePage), new DrillInNavigationTransitionInfo());
		}

		public Frame GetContent() => rootFrame;
		public static MainWindow GetInstance() => ISingleton<MainWindow>.Instance;
	}
}
