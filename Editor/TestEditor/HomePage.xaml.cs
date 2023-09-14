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
			FileSavePicker picker = new();
			picker.FileTypeChoices.Add("Map File", new List<string>() { ".gmap" });
			picker.FileTypeChoices.Add("Archieved Map File", new List<string>() { ".zip" });

			var window = this.GetWindow();
			var hWnd = WinRT.Interop.WindowNative.GetWindowHandle(window);
			WinRT.Interop.InitializeWithWindow.Initialize(picker, hWnd);

			var file = await picker.PickSaveFileAsync();
			if (file != null)
			{
				//PickAFileOutputTextBlock.Text = "Picked file: " + file.Name;
			}
			else
			{
				//PickAFileOutputTextBlock.Text = "Operation cancelled.";
			}
		}
		private async void OpenButton_Click(object sender, RoutedEventArgs e)
		{
			FileOpenPicker picker = new()
			{
				ViewMode = PickerViewMode.Thumbnail
			};
			picker.FileTypeFilter.Add(".gmap");

			var window = this.GetWindow();
			var hWnd = WinRT.Interop.WindowNative.GetWindowHandle(window);
			WinRT.Interop.InitializeWithWindow.Initialize(picker, hWnd);

			var file = await picker.PickSingleFileAsync();
			if (file != null)
			{
				//PickAFileOutputTextBlock.Text = "Picked file: " + file.Name;
			}
			else
			{
				//PickAFileOutputTextBlock.Text = "Operation cancelled.";
			}
		}
	}
}
