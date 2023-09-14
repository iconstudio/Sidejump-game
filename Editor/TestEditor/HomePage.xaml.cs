using Microsoft.UI;
using Microsoft.UI.Xaml.Input;

using Windows.ApplicationModel;
using Windows.Storage.Pickers;
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
		private async void CreateButton_Click(object sender, RoutedEventArgs e)
		{
			var picker = FilePickHelper.OpenSavePicker(this.GetWindow());
			if (picker is not null)
			{
				await picker;

				if (picker.IsCompletedSuccessfully)
				{
					var file = picker.Result;
					var name = file.Name;
				}
				else
				{
					// Do nothind
				}
			}
		}
		private void OpenButton_Click(object sender, RoutedEventArgs e)
		{
			var file = FilePickHelper.OpenLoadPicker(this.GetWindow());

		}
	}
}
