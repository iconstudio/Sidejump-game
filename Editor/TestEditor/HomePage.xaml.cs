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
			FileOpenPicker picker = new();
			picker.FileTypeFilter.Add(".gmap");

			// Clear previous returned file name, if it exists, between iterations of this scenario
			//TextBox OutputTextBlock = new();
			//OutputTextBlock.Text = "";

			// Create a file picker
			var openPicker = new Windows.Storage.Pickers.FileOpenPicker();

			// Retrieve the window handle (HWND) of the current WinUI 3 window.
			var window = this.GetWindow();
			var hWnd = WinRT.Interop.WindowNative.GetWindowHandle(window);

			// Initialize the file picker with the window handle (HWND).
			WinRT.Interop.InitializeWithWindow.Initialize(openPicker, hWnd);

			// Set options for your file picker
			openPicker.ViewMode = PickerViewMode.Thumbnail;
			openPicker.FileTypeFilter.Add("*");

			// Open the picker for the user to pick a file
			var file = await openPicker.PickSingleFileAsync();
			if (file != null)
			{
				//PickAFileOutputTextBlock.Text = "Picked file: " + file.Name;
			}
			else
			{
				//PickAFileOutputTextBlock.Text = "Operation cancelled.";
			}
		}
		private void OpenButton_Click(object sender, RoutedEventArgs e)
		{

		}
	}
}
