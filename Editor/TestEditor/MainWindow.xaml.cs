using Microsoft.UI.Xaml.Media;
using Microsoft.UI.Xaml.Media.Animation;
using Microsoft.UI.Windowing;
using Microsoft.UI.Composition.SystemBackdrops;

namespace TestEditor
{
	public sealed partial class MainWindow : Window
	{
		private readonly DesktopAcrylicBackdrop acrylicBackdrop;
		private static MainWindow Instance;

		public MainWindow()
		{
			if (Instance is not null)
			{
				throw new MainWindowDoubledException("Duplicated main window");
			}

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
		public Frame GetContent() => rootFrame;
		public static MainWindow GetInstance() => Instance;
		}

	[Serializable]
	class MainWindowDoubledException : ApplicationException
	{
		public MainWindowDoubledException() : base()
		{ }
		public MainWindowDoubledException(string message) : base(message)
		{ }
	}
}
