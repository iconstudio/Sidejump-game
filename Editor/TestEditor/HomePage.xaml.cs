using System.Diagnostics;

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
			var state = AnimatedIcon.GetState(settingBtnIcon);
			if (state is not null && state != "PointerOver")
			{
				AnimatedIcon.SetState(settingBtnIcon, "PointerOver");
			}
		}
		private void SettingBtn_PointerExited(object sender, PointerRoutedEventArgs e)
		{
			AnimatedIcon.SetState(settingBtnIcon, "Normal");
		}
		private async void CreateButton_Click(object sender, RoutedEventArgs e)
		{
			var picker = FilePickHelper.OpenSavePicker(this.GetWindow());

			using var fstream = await FilePickHelper.TryOpenWriteFile(picker);

			if (fstream is null || !fstream.CanWrite)
			{
				Debug.Print("Inappropriate file stream");
				return;
			}
		}
		private async void OpenButton_Click(object sender, RoutedEventArgs e)
		{
			var picker = FilePickHelper.OpenLoadPicker(this.GetWindow());

			using var fstream = await FilePickHelper.TryOpenReadOnlyFile(picker);

			if (fstream is null || !fstream.CanRead)
			{
				Debug.Print("Inappropriate file stream");
				return;
			}

			var length = fstream.Length;
			if (0 == length)
			{
				Debug.Print("Zero sized file");
				return;
			}

			fstream.Seek(0, SeekOrigin.Begin);

			byte[] mbuffer = new byte[length];
			var work_sz = await fstream.ReadAsync(mbuffer);

			if (0 == work_sz)
			{
				Debug.Print("Read zero size");
				return;
			}
		}
	}
}
