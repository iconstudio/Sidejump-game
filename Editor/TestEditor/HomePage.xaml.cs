using Microsoft.UI.Xaml.Input;
using Microsoft.UI.Xaml.Media.Animation;
using Microsoft.UI.Xaml.Navigation;

using Windows.ApplicationModel;
using Windows.Storage;
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
		protected override void OnNavigatedTo(NavigationEventArgs e)
		{
			settingBtn.AddHandler(PointerPressedEvent,
				new PointerEventHandler(settingBtn_PointerPressed), true);
			settingBtn.AddHandler(PointerReleasedEvent,
				new PointerEventHandler(settingBtn_PointerReleased), true);

			base.OnNavigatedTo(e);
		}
		protected override void OnNavigatedFrom(NavigationEventArgs e)
		{
			settingBtn.RemoveHandler(PointerPressedEvent,
				(PointerEventHandler) settingBtn_PointerPressed);
			settingBtn.RemoveHandler(PointerReleasedEvent,
				(PointerEventHandler) settingBtn_PointerReleased);

			base.OnNavigatedFrom(e);
		}
		private void settingBtn_PointerPressed(object sender, PointerRoutedEventArgs e)
		{
			AnimatedIcon.SetState(settingBtnIcon, "Pressed");
		}
		private void settingBtn_PointerReleased(object sender, PointerRoutedEventArgs e)
		{
			AnimatedIcon.SetState(settingBtnIcon, "Normal");
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
			var picker = await FilePickHelper.OpenSavePicker(this.GetWindow());
			if (picker is StorageFile mapfile)
			{
				MapHelper.MemoLastFile(mapfile);

				NavigationHelper.Goto(typeof(EditorPage), new DrillInNavigationTransitionInfo(), EditorTransitionInfo.saveTransition);
			}
		}
		private async void OpenButton_Click(object sender, RoutedEventArgs e)
		{
			var picker = await FilePickHelper.OpenLoadPicker(this.GetWindow());
			if (picker is StorageFile mapfile)
			{
				MapHelper.MemoLastFile(mapfile);

				NavigationHelper.Goto(typeof(EditorPage), new DrillInNavigationTransitionInfo(), EditorTransitionInfo.loadTransition);
			}
		}
	}
}
