using Microsoft.UI.Composition.SystemBackdrops;
using Microsoft.UI.Windowing;
using Microsoft.UI.Xaml.Media;

namespace TestEditor
{
	public sealed partial class ToolWindow : Window
	{
		private readonly DesktopAcrylicBackdrop acrylicBackdrop;

		public ToolWindow()
		{
			InitializeComponent();

			if (DesktopAcrylicController.IsSupported())
			{
				acrylicBackdrop = new();
				SystemBackdrop = acrylicBackdrop;
			}
		}
	}
}
