using System.Diagnostics;

using Microsoft.UI.Xaml.Input;

using Windows.ApplicationModel;
using Windows.UI;

namespace TestEditor
{
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

			var mapfile = await picker;
			if (mapfile is not null)
			{
				MapHelper.MemoLastFile(mapfile);

				var testmap = new Map();
				if (MapHelper.SaveMap(testmap, mapfile))
				{
					NavigationHelper.Goto(typeof(EditorPage));
				}
			}
		}
		private async void OpenButton_Click(object sender, RoutedEventArgs e)
		{
			var picker = FilePickHelper.OpenLoadPicker(this.GetWindow());

			var mapfile = await picker;
			if (mapfile is not null)
			{
				MapHelper.MemoLastFile(mapfile);

				if (MapHelper.LoadMap(mapfile))
				{
					NavigationHelper.Goto(typeof(EditorPage));
				}
			}
		}
	}
}
