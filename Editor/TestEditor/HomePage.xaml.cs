using Microsoft.UI.Xaml.Input;

using Windows.ApplicationModel;
using Windows.UI;

// To learn more about WinUI, the WinUI project structure,
// and more about our project templates, see: http://aka.ms/winui-project-info.

namespace TestEditor
{
	/// <summary>
	/// An empty page that can be used on its own or navigated to within a Frame.
	/// </summary>
	public sealed partial class HomePage : Page
    {
        private static readonly Color Transparent = Color.FromArgb(0, 0, 0, 0);

		private static readonly string appVersion = string.Format(null, "v{0}.{1}.{2}.{3}",
					Package.Current.Id.Version.Major,
					Package.Current.Id.Version.Minor,
					Package.Current.Id.Version.Build,
					Package.Current.Id.Version.Revision);

		public HomePage()
        {
            InitializeComponent();

			appVersionText.Text = appVersion;
		}

		private void SettingBtn_PointerEntered(object sender, PointerRoutedEventArgs e)
		{
			AnimatedIcon.SetState(settingBtnIcon, "PointerOver");
		}
		private void SettingBtn_PointerExited(object sender, PointerRoutedEventArgs e)
		{
			AnimatedIcon.SetState(settingBtnIcon, "Normal");
		}
	}
}
